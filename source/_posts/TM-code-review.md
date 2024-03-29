---
title: TM-code-review
date: 2021-09-21 22:09:24
tags:
  - expert
  - code review
---

分享一篇内部CodeReview时的记录, 主讲是技术总监, 听讲的是公司新手村一众小菜鸡

没有仔细整理过, 看起来可能有点杂乱, 见谅了.

+ 20210819 13:30 -> 15:30

+ "对代码要有敬畏之心"
+ "代码整洁"

+ 书: 代码大全("Code Complete", 读过了, 推荐)
+ 书: 重构(["Refactoring"](https://martinfowler.com/books/refactoringRubyEd.html), , 读过了, 推荐)
+ 书: 代码整洁之道("Clean Code")
+ 书: 敏捷软件开发: 原则、模式与实践("Agile Software Development, Principles, Patterns, and Practices", 读过了, 推荐)

+ 重构
    + "代码写好以后, 需要反复重构" 直到 不需要重构为止
    + 重构是基本的能力, 需要具备这个意识和能力
+ 设计模式 很重要

+ 从入口开始看代码(action)
    + 从 需求方/调用方 入手

+ SOLID
    + 单一职责 SRP
    + 开闭原则 OCP
    + 里氏替换 LSP
    + 接口隔离 ISP
    + 依赖倒置 DIP

+ 一行内尽可能只表达一个意思, 逻辑越少越好 -> 单一职责
+ 尽可能别写注释; 如果有无效代码, 删掉

+ 因为 实现的复杂度, 把业务逻辑复杂化了
    + 应该: 把业务逻辑暴露出来, 把实现封装起来
+ 函数的目的是 封装复杂度

+ "好的代码, 初级程序员能快速读懂;"
+ "代码好坏与否, 一个重要原则是 初级程序员能否快速读懂"
+ "代码就是设计文档, 顺便让计算机执行"
    + 代码是写出来让人读的, (顺便让计算机执行)

+ 迪米特法则(Law of Demeter)
    + 只关心和你直接相关的东西

+ 一个类里的函数越少越好
+ 客户端不应使用他不依赖的方法
+ 提前返回 / 及早返回
    + 可以减少if-else的嵌套

+ 顺序: 先封装为全局函数, 尽量不要引入成员变量(状态)
    + 成员变量 表示 状态
    + 除非 通过传参解决不了
    + 成员变量的维护成本很高
    + 封装一个业务时, 优先使用全局函数
    + 全局变量最好不要有, 有的话 要尽量少

+ 什么时候引入module?
    + 当有一组函数, 想给他们分组时

+ 类的目的, 是把一组相关方法放在一起
+ 什么时候提取成员变量?
    + 不需要一开始就用高层设计
    + 当需要成员变量时, 才开始考虑类
+ 什么时候需要成员变量?
    + "当一个类的两个public函数, 都需要使用同一个变量的时候, 可以引入成员变量"

+ 三个词
    + overview
    + summary / list (index)
    + detail 详情    (show)

+ 思考 基于实现/基于设计原则
    + 业务
    + 封装
    + 接口
    +
    + 顺序很重要, 什么样的顺序?
    +
    + 设计驱动?
    + 实现驱动? *
    + "从调用方看问题, 问题会得到简化"(实现驱动)
    + 重要性: 获取信息 > 封装的思路
    + 一个类的 职责/价值, 是 获取信息 还是 封装?

+ 一个有经验的工程师, 要能接受各种各样的方案, 能说清楚每个方案的优缺点
+ 依赖管理
+ "model层是对数据库的封装, 他不是对网络请求的封装"
+ 当我们可以选择低耦合的实现时, (是不是)应该选择低耦合的实现?
+ "为什么要引入耦合? 是否有充足的理由?"
+ "不要过早设计", (做应用开发)当需求真实发生时, 再根据需求做重构
+ public 函数变少, 耦合就会变低
+ 思考: 某个设计, 对此时此刻的需求来说是不是过度了
+ 设计思路: 自顶向下/自底向上

