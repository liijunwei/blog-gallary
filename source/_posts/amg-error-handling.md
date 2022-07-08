---
title: amg error handling
date: 2022-07-08 23:26:33
tags:
  - AMG
---

见识真的很重要, 如果我早点意识到"Error Handing"的正确做法是使用"Error Service", 可以省下不少时间, 减少很多没有意义的成就感, 获得真正的提高

## 遇到的问题

在做AMG时, 经常在苦恼错误的处理:

+ 捕获了, 会收不到通知
+ 不捕获, 会老是收到提示
+ 打印出backtrace有那么长一串, 找不到关键信息
+ 而且每次都得查日志
+ 定时任务(whenever)失败了, 除了查日志没办法发现吗?

## 做过的尝试(浪费过的时间)

+ 在每个重要的rescue里, 增加企业微信机器人的通知
+ 增加`error_logs`表, 在rescue里记录错误信息, 并且专门给它写了个index页和show页面用于定位问题(当时还洋洋自得...)
+ 为`Exception`类增加`monkey patch`, 在每个rescue里, 打印或者记录`e.to_hash`
```ruby
class Exception
  def to_hash(request_id = nil)
    hash = {}
    hash[:request_id] = request_id if request_id
    hash[:class]      = self.class.to_s
    hash[:message]    = self.message
    hash[:backtrace]  = self.app_backtrace

    return hash
  end

  def app_backtrace
    return self.backtrace.select {|trace| trace.include?(Rails.root.to_s)}
  end
end
```
+ 由于错误信息太多, 做过几轮收敛, 忽略不重要的错误
+ 为sidekiq的错误信息写了个`error_handler`, 里面打印错误信息和记录`error_log`, 这步倒问题不大
+ ... 记不清了


## 正确的做法

https://www.mikeperham.com/2013/08/25/please-use-an-error-service/

error handling这个问题的解决方案是: 使用 bugsnag 之类的`Error Service`

应用里不该捕获所有的`unknown exceptions`, `rescue StandardError => e` 甚至 `rescue Exception => e` 都是不可取的

错误应该被暴露出去, 然后及时修复; 由于错误被吞掉导致的问题很让人恼火, 而且有时候会很难排查

### 使用 Error Service(以bugsnag为例) 有什么好处呢?

+ 代码只需要处理已知的异常, 会干净一些
+ 意料外的异常可以报告给bugsnag, 可以触发通知, 查看backtrace, error trending...
+ 可以直接在bugsnag上创建bug, 分配给研发团队处理
+ 不用再在日志里`grep error`了


对于难发现定时任务的报错, 其实也有解决方案: 使用sidekiq的插件 sidekiq-scheduler, 放弃linux的cron服务

有什么好处呢?

1. sidekiq-scheduler 沿用了 sidekiq的web页面, 增加了一个tab, 显示定时任务的状态等信息, 一目了然
2. 可以在页面上触发定时任务, 不需要登录服务器
3. 如果出错了, 可以在页面上看到(和失败的sidekiq任务类似), 并且可以利用sidekiq的重试机制


## 反思

+ 如果我早点理解这些问题的正确解法, 可以少花不少时间在上面; 可惜不知为什么, 竟然没有人提醒我, 大概是因为我只顾埋头自己干, 太少请教其他人
+ 为什么 在我看到 https://www.mikeperham.com/2013/08/25/please-use-an-error-service/ 这篇文章后仍然没有意识到 error service 是什么意思, 能怎么解决我的问题? 大概是我看到了新的名词, 没有主动去做了解, 没有把大佬的话放在心上导致的
+ 为什么sidekiq-scheduler 这样比较成熟的解决方案, 我竟然很久之后才发现? 大概是搜索技能和好奇心的缺失: 如果在 https://rubygems.org/ 上搜索一下 "sidekiq", 会发现一堆有趣的插件; 如果我真的遇到了项目中的痛点, 要明确自己想要什么, 然后去搜索解决方案, 我遇到的问题, 大概率其他人也会遇到
+ 陷入了"有一把锤子, 看谁都是钉子"的怪圈: 当时的场景中, 太熟悉通过 企业微信机器人 发消息的机制, 没有细想事情的正确做法应该是什么样的


