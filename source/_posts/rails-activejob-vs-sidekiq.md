---
title: rails activejob vs sidekiq
date: 2022-09-03 10:39:02
tags:
  - sidekiq
  - activejob
  - best practice
---

**WIP**

最初一直不喜欢rails里的activejob

原因很简单, 日志里它的日志很难懂

后来花时间读了一下文档, 了解到了gid这个概念, 知道了它里面有一些和controller里一致的`rescue_from`等等功能, 觉得它确实有优势

日志也能看懂了, 不那么排斥它了

甚至因为gid的缘故, 有点喜欢这个设计

但是, sidekiq里提倡的最佳实践是: 使用简单参数, 很清晰易懂, 用gid其实也做到了一样的事, 而且他可以传递model实例, 挺好的优势

直到昨天, 看到同事的一个pr修改了activejob的参数(由model实例改为id), 我提出是不是没必要这样, 因为前面说到的原因

但是他展示给我 如果在log里搜索 "Sidekiq::Extensions::DelayedClass  ARGS" 会发现, 虽然perform接口的model实例会被序列化为gid, 但是这种延时的任务, 实际上还是序列化为了yml

所有model实例的所有信息都被存储了下来, 然后做反序列化, 所有信息都被记入了log里面, 太糟糕了

+ 反思.1: sidekiq的代码没读全, activejob的代码没读全, 重大的疏漏
+ 反思.2: 简单的是好的, 简单的最佳实践也需要认真了解其背后的逻辑
+ 反思.3: 不要对自己信奉的东西有太强的自信, 多多沟通和交流, 谦虚的向大家学习

