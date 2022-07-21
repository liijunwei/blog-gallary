---
title: Rubocop Inspired Learning
date: 2022-07-22 07:07:01
tags:
  - ruby
  - lint
  - static analysis tool
---

## 背景

第一次知道"rubocop"这个关键字并且开始用它, 是在一次分享"exception handling"后

当时分享的主题是, ruby里的exception类有的继承关系, 最常被捕获的异常应该是StandError及它的子类, 不该捕获Exception类 [参考](./amg-error-handling.md)

最后的结论是, 希望大家了解一下 Exception相关类的继承关系, 捕获该被捕获的异常

分享的最后, 有人提到了rubocop, 我了解了一下, 才意识到, 这件事其实可以不用写代码的人主动去检查和注意, 完全可以交给lint程序自己检查

`be rubocop --only Lint/RescueException`

## 问题

系统变复杂后, 代码里几乎不可避免的出现了一大团异常处理的代码

尤其是在代码入口处, 一个个的`rescue` 看得头大, 有一次还因为没注意到一个更具体(specific)的异常被一个更通用(genral)的异常给遮蔽(shadowed 这个描述是后来知道的, 最初没有这个准确的概念)掉了, 好一阵debug才发现原因

这时候我想这种检查是不是也可以自动完成呢?

## 思路

`问题 -> 需求 -> 自己实现? -> 查查已有工具 -> 找到已有工具 -> 验证 -> 有问题 -> 尝试解决/求助 -> ...`

第一反应还是自己写个工具检查

但是多了个心眼, 先查查有没有已有的工具已经做了这件事?

事实证明这个问题早有人遇到过, 并且有了解决办法: [`be rubocop --only Lint/ShadowedException`](https://docs.rubocop.org/rubocop/cops_lint.html)

既然已经有了工具, 那试着用用呗

结果不理想, 没法识别出`restclient`里被遮蔽的异常, 试了下看rubocop的代码, 一下看懵了, 暂时放弃

于是换了个更直接的方式: [给rubocop提issue: Lint/ShadowedException cop not working as expected for RestClient::RequestFailed exception](https://github.com/rubocop/rubocop/issues/10823)

作者很快做了回复:

> RuboCop is a static analysis tool, it doesn't know inheritance relationships at runtime. It has false negatives for unknown inheritance relationships.

这里出现了一个不了解的概念: "static analysis tool"

经过 rubocop -> parser -> ast -> wiki: Abstract syntax tree -> wiki: Program analysis

才算意识到 "Program analysis can be performed without executing the program (static program analysis), during runtime (dynamic program analysis) or in a combination of both."

+ 在 不执行代码的前提下 检查代码, 这种叫做 静态程序分析
+ 在 执行代码的前提下 检查代码, 这种叫做 动态程序分析

而rubocop是一个静态程序分析工具, `RestClient::RequestFailed`相关的异常只能在运行时确定(需要 `require 'rest-client'`)

这下算是搞明白了作者回复的含义

## 学习路径

coding -> problem -> analysis: can be automated? -> tool available?

## 反思

+ 好的问题 + 兴趣 引向好的结果
+ 不要一上来就想着自己实现, 重复造轮子, 并且做出来的轮子不一定圆
+ 眼界要开阔, 多多求助
+ 动手尝试, 实践
+ 读wiki/manual要仔细一点

## 接下来的TODO

rubocop 里的 ShadowedException cop, 没法检查出需要运行时才能判断出的继承关系

但是他可以检测出 ruby里已有的一些异常(TODO 验证一下)

处理我的这个需求有两种方式

1. 自己实现一个新的工具, 专门做这件事
    + 有点重新造轮子, 但是只要能问题就是好的(做好了demo)

2. 把这个能力集成进`ShadowedException`里面, 这里涉及到比较难的问题是
    + 需要读懂rubocop的代码
    + rubocop是"static analysis tool", 加入这种 运行时检查的功能, 似乎和他的定义冲突, 怎么处理这种关系?


