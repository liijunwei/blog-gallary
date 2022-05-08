---
title: "记录 从sublime搜索结果显示为binary引发的思考和行动"
date: 2022-05-08 16:43:07
tags:
  - efficiency
  - first-time
  - fun
  - linux
  - ruby
  - shell
  - sublime
  - tradeoff
---

昨天加今天, 基本搞明白了一个困扰我很久的问题, 有很多收获, 在这里记录一下

+ 最初的问题:
    + 有一次在代码库里搜索一个关键字, sublime的结果显示搜索到了, 但是没有preview, 还把那个文件标为了"binary", [就像这样](https://github.com/liijunwei/char_detector/blob/main/image/Xnip2022-05-08_13-52-58.png)
    + 当时初步定位到原因是 那个文件里包含了一个 [ASCII control characters](http://www.csc.villanova.edu/~tway/resources/ascii-table.html) 里的 BS(backspace), 它在编辑器里渲染的不是正常的字符, 所以能看出它是特殊的, 但是当时对unicode/ascii 和字符编码都了解很少, 不知道是什么意思, 发现把这个字符删掉, 能让搜索结果恢复正常
    + 为什么这种字符让文件的搜索结果变成了binary?
    + 这些个特殊字符是什么?
    + 怎么能快速定位到他们?

+ 学习过程
    + 遇到的问题: 之后这类的问题又遇到了几次, 但是这次文件很长, 没法快速找到这样的"特殊字符"
    + 这时候最要命的问题是, 不确定它是原因, 不知道这个东西叫什么, 所以在搜索的时候没有头绪
    + 搜索结果中, 多次提到了"字符编码", utf-8, unicode, ascii这些概念, 我发现我对这些概念了解的很含混, 于是开始找相关的资料
        + [极客时间 - 左耳听风 - 字符编码方面](https://time.geekbang.org/column/article/8217)
        + [关于字符编码，你所需要知道的（ASCII,Unicode,Utf-8,GB2312…）](http://www.imkevinyang.com/2010/06/%E5%85%B3%E4%BA%8E%E5%AD%97%E7%AC%A6%E7%BC%96%E7%A0%81%EF%BC%8C%E4%BD%A0%E6%89%80%E9%9C%80%E8%A6%81%E7%9F%A5%E9%81%93%E7%9A%84.html)
        + [notes](https://github.com/liijunwei/practice/tree/main/unicode)
    + 读完还是很懵, 直到我捕捉到两条关键信息
        + [ascii字符集可以分为两类](https://theasciicode.com.ar/): `可打印字符`和`控制字符`

