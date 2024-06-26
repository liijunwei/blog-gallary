---
title: Tradeoff Collection
date: 2022-01-29 00:01:46
tags:
  - art
  - tradeoff
---

> I observed a lot of trade-offs.
> I would call Trade Off some kind of Art.
> Tradeoff collection therein.

### [Space | Time Tradeoff](https://en.wikipedia.org/wiki/Space%E2%80%93time_tradeoff#:~:text=A%20space%E2%80%93time%20Trade%20off,space%20usage%20with%20decreased%20time.)

A space–time Tradeoff or time–memory trade-off in computer science is a case where an algorithm or program trades increased space usage with decreased time.

Here, space refers to the data storage consumed in performing a given task (RAM, HDD, etc), and time refers to the time consumed in performing a given task (computation time or response time).

### Code Changeability/Simplicity | Code Readability Tradeoff

hint from "99-bottles-of-oop"

+ abstraction -> changeability(hard to understand)
+ concrete -> easy to read(hard to change)

### Security | Effiency Tradeoff

cryptography

+ The more complex the encryption algorithm is, the more secure it will be, while it'll take more time to encrypt/dencrypt

### even good (or trendy) solutions add complexity

+ [Everything is a trade-off, even good (or trendy) solutions add complexity.](https://thoughtbot.com/blog/testing-null-objects)

+ [null-object pattern is not silver bullet](https://github.com/liijunwei/practice/blob/main/ruby/design-pattern/null-object-pattern2.rb)

### Use sidekiq or use sidekiq with rails activejob

+ sidekiq: powerful/simple
+ activejob: more rails-favored features

### ease of use | feature rich

+ beginners want programs/interface to be easy to use

+ advanced users want programs/interface to be more powerful

### top -> down design | bottom -> up design

"the art of unix programming" ch4.3.1

### 接口复杂度 | 实现复杂度

"the art of unix programming" ch13.1.2

### features/performance | price

["Fast and resilient web apps: Tools and techniques - Google I/O 2016"](https://youtu.be/aqvz5Oqs238?t=1132)

### Event-carried state transfer

+ more decoupling
+ more availablity

+ less data consistency(eventual consistency)


