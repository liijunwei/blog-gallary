---
title: RestClient Issue
date: 2022-03-11 23:53:37
tags:
  - ruby
  - restclient
  - 坑
---

记录一下使用[RestClient](https://github.com/rest-client/rest-client)这个Gem时遇到的一个坑.

版本: rest-client (2.1.0)

# TLDR

如果直接使用封装过的 `RestClient.get`/`RestClient.put`/`RestClient.post` 等方法, 当遇到异常的响应时(比如400 bad request), 得不到任何有用的信息

应该使用带块的方式调用, 用块参数接收 response, request 和 result, 不使用块会导致异常时丢失信息

# 示例

用rails准备一个简单的接口, 响应 400, 并返回错误的信息

```ruby
# config/routes.rb
post 'demo', to: "demo#test"

# app/controllers/demo_controller.rb
class DemoController < ApplicationController
  def test
    render :json => {msg: 'this msg explains why this is a bad request'}, :status => :bad_request
  end
end

# 进入 rails console

# case1: 不用块
[23] pry(main)> RestClient.post("localhost:3000/demo", {}) # => nil
# RestClient::BadRequest: 400 Bad Request
# from /Users/lijunwei/.rvm/gems/ruby-2.6.3@api-provider/gems/rest-client-2.1.0/lib/restclient/abstract_response.rb:249:in `exception_with_response'

# case2: 用块
[24] pry(main)> RestClient.post("localhost:3000/demo", {}) {|response, request, result| puts "response.body: #{response.body}\nrequest.body: #{request.args}\nresult.body: #{result.body}"} # => nil
# response.body: {"msg":"this msg explains why this is a bad request"}
# request.body: {:method=>:post, :url=>"localhost:3000/demo", :payload=>{}, :headers=>{}}
# result.body: {"msg":"this msg explains why this is a bad request"}
```

可以看到, 用块的这个可以获取到响应里返回的详细信息

这个区别是在调用JIRA7和企业微信的API时发现的, 现象是: 用restclient调用api只返回了400, 用postman调试却能得到错误信息, 使用net/http调试, 也能得到错误信息

经过调试和阅读文档才意识到, 信息是被RestClient给吞了

[看源码](https://github.com/rest-client/rest-client/blob/2c72a2e77e2e87d25ff38feba0cf048d51bd5eca/lib/restclient/abstract_response.rb#L128)可以看到, 4XX和5XX的状态吗, 如果响应里有信息, RestClient是不会解析和返回的, 只会包装一个对应的异常

看这注释的意思, 这是个feature, 不是个bug, 但是假如确实有人在 4XX 响应里返回了信息(就像JIRA7和企业微信机器人接口那样), 那使用RestClient, 就得小心了...

```ruby
    # lib/restclient/abstract_response.rb

    # Return the default behavior corresponding to the response code:
    #
    # For 20x status codes: return the response itself
    #
    # For 30x status codes:
    #   301, 302, 307: redirect GET / HEAD if there is a Location header
    #   303: redirect, changing method to GET, if there is a Location header
    #
    # For all other responses, raise a response exception
    #
    def return!(&block)
      case code
      when 200..207
        self
      when 301, 302, 307
        case request.method
        when 'get', 'head'
          check_max_redirects
          follow_redirection(&block)
        else
          raise exception_with_response
        end
      when 303
        check_max_redirects
        follow_get_redirection(&block)
      else
        raise exception_with_response
      end
    end

    def exception_with_response
      begin
        klass = Exceptions::EXCEPTIONS_MAP.fetch(code)
      rescue KeyError
        raise RequestFailed.new(self, code)
      end

      raise klass.new(self, code)
    end
```

# 结论: 如果使用RestClient, 一定要使用块; 如果用其他lib, 需要注意一下有没有类似的问题

## 思路.1 使用`Request.execute(:method => :get, :url => url, :headers => headers, &block)` 封装自己的请求

## 思路.2 使用`RestClient.get`等封装后的方法, 并使用块

示例:
```ruby
def make_qywxrobot_request(url, payload)
  RestClient.post(url, payload.to_json, content_type: :json) do |response, request, result|
    response_body = JSON.parse(response)
    response_code = response.code
    request_id    = SecureRandom.hex
    errcode       = response_body["errcode"]

    hash = {}
    hash[:request_id]    = request_id
    hash[:request_args]  = request.args
    hash[:response_code] = response_code
    hash[:response_body] = response_body

    if response_code == 200 && errcode == 0
      return response_body
    elsif response_code == 200 && known_qywx_errcode?(errcode)
      # exception handler 1
      Rails.logger.error("#{__method__} #{hash.to_json}")
    else
      # exception handler 2
      Rails.logger.error("#{__method__} #{hash.to_json}")
      raise "调用企业微信接口发送告警消息失败"
    end
  end
end

# https://developer.work.weixin.qq.com/document/path/95390
def known_qywx_errcode?(errcode)
  errcode == 45009 ||
  errcode == 45033
end
```

## 思路.3 用ruby自带的Net::HTTP自己封装吧

目前没看出RestClient有什么优势...(可能是没遇到很复杂的http请求的场景)


# 反思

1. 又仔细读一下文档, [发现文档里还是提供了些头绪的](https://github.com/rest-client/rest-client#block_response-receives-raw-nethttpresponse), 只是遇到问题时没读懂

2. 这个"信息被吞"的问题, 和Error Handling有点像, 很多时候异常被吞掉是很恼人的事情, 一定要想清楚再决定是否 `rescue`

+ 这里有几点体会:
    + 代码里应该尽量少写begin, rescue, 尤其是rescue所有Exception更要少些, 代码的可读性会有提升, 可维护性也会变好一些, 因为出错时会崩, 崩了能找到源头; 如果满篇rescue, 那么排查起来就会很费劲了
    + 一定要理解`rescue Exception => e` 和 `rescue => e`的区别, 多数情况下前者是万万不可的
        + ref: https://www.mikeperham.com/2012/03/03/the-perils-of-rescue-exception/
        + ref: https://www.honeybadger.io/blog/ruby-exception-vs-standarderror-whats-the-difference/
    + 必要的地方要做容错处理, 不能崩; 但是这种地方如果崩了, 要能及时发出告警, 记录好现场数据以备排查和修复, 绝对不能简单吞了完事
    + 捕获的异常越具体, 或者说处理异常的代码越少, 说明写代码时考虑的越周到(前提是这种异常确实会发送), 代码会干净很多, 这样的代码无论是使用、阅读还是维护, 都会很舒服

3. 没必要时, 可以不考虑使用lib([例入写gem时, 要尽量少的引入依赖](https://www.mikeperham.com/2016/02/09/kill-your-dependencies/))

4. 使用开源lib时, 最好能先了解它, 不要拿来就用, 不然遇到了奇怪的问题时会很头疼; 如果有安全问题也会很麻烦的, 甚至会有巨大的损失







