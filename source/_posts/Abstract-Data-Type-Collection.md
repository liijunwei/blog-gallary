---
title: Abstract Data Type Collection
date: 2023-02-07 22:23:37
tags:
    - collection
---

"和任何编程概念一样，理解抽象数据类型的威力和用法的最好办法是仔细研究更多的例子和实现" --- algs4 ch1.2

- Counter
- Interval1D
- Interval2D
- Date
- Transaction
    - from_user
    - to_user
    - created_at
    - amount
    - currency
    - souce_id
    - source_type
- List
- Stack
- Queue
- Bag
- Tree

ref: [Reading 10: Abstract Data Types](https://web.mit.edu/6.031/www/sp21/classes/10-abstract-data-types/)


昨天复习优先队列的时候，才真正注意到 ADT 和 data structure 是两个不同的概念

比如优先队列(priority queue)是一种ADT, 所以他的实现可以有多种, 基于数组实现的而叉堆只是实现它的一种数据结构

比如栈(stack)是一种ADT, 基于数组实现的栈是一种数据结构, 基于链表实现的栈也是一种数据结构

(还是不够清晰，甚至感觉有错误...)
