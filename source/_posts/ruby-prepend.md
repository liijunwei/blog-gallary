---
title: ruby-prepend
date: 2022-07-08 23:11:23
tags:
  - ruby
---

最近在项目代码里看到了 `prepend` 的用法, 读了文档, 基本明白了它的用法; 但是对于说它是为了解决之前 `alias_methods` 的问题的这部分讨论还没看明白(可能是我没怎么用过alias_method)

在我的理解中这几点比较关键:

1. 和ruby其他的hook(`inherited` `included`...)类似, prepend 也有自己的hook: `prepended`
2. prepend把模块里的方法插入到方法查找链里面, 可以覆盖当前类里的方法定义

## 示例

+ 定义一个普通的类, run方法会遍历并打印参数, 然后返回结果

```ruby
class Service
  # perform some real work
  def run(args)
    args.each do |arg|
      puts "arg: #{arg}"
    end
    {result: "ok"}
  end
end

p Service.new.run(["888", "999"])
# arg: 888
# arg: 999
# {:result=>"ok"}
```

+ 如果给它`prepend`一个module `ServiceDebugger`, 里面定义一个同名的方法, 这个模块里的方法定义会覆盖 `Service` 里的方法定义

```ruby
module ServiceDebugger
  def run(args)
    puts "Service run start: #{args.inspect}"
  end
end

class Service
  prepend ServiceDebugger

  # perform some real work
  def run(args)
    args.each do |arg|
      puts "arg: #{arg}"
    end
    {result: "ok"}
  end
end

p Service.new.run(["888", "999"])
# Service run start: ["888", "999"]
# nil
```

+ module `ServiceDebugger` 里面可以调用`super`方法, 调用原始定义的方法, 类似 `around_hook` 里的 `yield`

```ruby
module ServiceDebugger
  def run(args)
    puts "Service run start: #{args.inspect}"
    result = super
    puts "Service run finished #{result}"
    {new_result: "ok"}
  end
end

class Service
  prepend ServiceDebugger

  # perform some real work
  def run(args)
    args.each do |arg|
      puts "arg: #{arg}"
    end
    {result: "ok"}
  end
end

p Service.new.run(["888", "999"])
# Service run start: ["888", "999"]
# arg: 888
# arg: 999
# Service run finished {:result=>"ok"}
# {:new_result=>"ok"}
```

+ 可以用这种机制, 在不修改原有代码的情况下, 增强原有的方法, 例如 增加日志; super前的代码类似于 `before_hook`, 之后的代码类似于`after_hook`

+ 此外, 可以在被prepend的模块里定义`prepended`, 里面实现一些自动触发的行为

```ruby
module ServiceDebugger
  def self.prepended(mod)
    puts "#{self} prepended to #{mod}"
  end
  # ...
end
```

是魔法吗? 不确定; 不知道其他语言有没有这么多hook 和灵活的用法

2022-07-09 09:47:43 update

不是魔法, hook的本质大概是在模块/类的生命周期中 提前定义好"如果存在则会被调用的代码块", 从外部看来就是hook了

用这种视角来看, 其他语言肯定也可以实现

核心大概是: "生命周期" 和 "封装"

很好例子就是 activerecord 里的 ["The Object Life Cycle"](https://guides.rubyonrails.org/active_record_callbacks.html#the-object-life-cycle)

清晰的定义 配合良好的封装, 使得activerecord的hook使用起来很方便


