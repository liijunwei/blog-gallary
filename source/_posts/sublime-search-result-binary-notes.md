---
title: "记录 从sublime搜索结果显示为binary引发的思考和行动(WIP)"
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

### 最初的问题

+ 有一次在代码库里搜索一个关键字, sublime的结果显示搜索到了, 但是没有preview, 还把那个文件标为了"binary", [就像这样](https://github.com/liijunwei/char_detector/blob/main/image/Xnip2022-05-08_13-52-58.png)
+ 当时初步定位到原因是 那个文件里包含了一个 [ASCII control characters](http://www.csc.villanova.edu/~tway/resources/ascii-table.html) 里的 BS(backspace), 它在编辑器里渲染的不是正常的字符, 所以能看出它是特殊的, 但是当时对unicode/ascii 和字符编码都了解很少, 不知道是什么意思, 发现把这个字符删掉, 能让搜索结果恢复正常
+ 为什么这种字符让文件的搜索结果变成了binary?
+ 这些个特殊字符是什么?
+ 怎么能快速定位到他们?

### 学习过程

+ 遇到的问题: 之后这类的问题又遇到了几次, 但是这次文件很长, 没法快速找到会导致问题的"特殊字符"
+ 最要命的问题是: 不确定它是原因, 不知道这个东西叫什么, 所以在搜索的时候没有头绪
+ 搜索结果中, 多次提到了"字符编码", utf-8, unicode, ascii这些概念, 我发现我对这些概念了解的很含混, 于是开始找相关的资料
    + [极客时间 - 左耳听风 - 字符编码方面](https://time.geekbang.org/column/article/8217)
    + [关于字符编码，你所需要知道的（ASCII,Unicode,Utf-8,GB2312…）](http://www.imkevinyang.com/2010/06/%E5%85%B3%E4%BA%8E%E5%AD%97%E7%AC%A6%E7%BC%96%E7%A0%81%EF%BC%8C%E4%BD%A0%E6%89%80%E9%9C%80%E8%A6%81%E7%9F%A5%E9%81%93%E7%9A%84.html)
    + [notes](https://github.com/liijunwei/practice/tree/main/unicode)
+ 读完还是很懵, 直到我捕捉到两条关键信息:
    + [ascii字符集可以分为两类](https://theasciicode.com.ar/): `可打印字符`和`控制字符`
    + [How do I replace or find non-printable characters in vim regex?](https://stackoverflow.com/questions/3844311/how-do-i-replace-or-find-non-printable-characters-in-vim-regex)
+ 接下来就很顺利了, 找到了这两份资料, 介绍正则表达式里 字符的分类
    + [POSIX Bracket Expressions](https://www.regular-expressions.info/posixbrackets.html)
    + [Ruby@Regexp Character Properties](https://ruby-doc.org/core-3.1.2/Regexp.html#class-Regexp-label-Character+Properties)
+ 开始写测试脚本, 验证用正则表达式能否快速定位到我想要的结果(可以)
+ 写个gem, 用TDD的方式把它完善一下吧

### 使用TDD实现这个[CharDetector](https://github.com/liijunwei/char_detector)的体会和反思

+ 此前我认真读了[99 Bottles of OOP](https://github.com/liijunwei/practice/tree/main/oop/99-Bottles-of-OOP)(好书, 极力推荐), 这是一次践行
+ 跟着书上的例子做和自己独立做区别很大, 它迫使我去进行痛苦的思考, 做出来以后很开心
+ red -> green -> refactor -> loop
+ 设计测试用例的过程, 就是设计程序api的过程, 很痛苦; 好在只需要做一次, 并且可以复用, 还能依靠测试用例保证快速重构
+ 过程中使用TDD简化了一些的设计, 清理了接口里不必要的东西, 拒绝了一些不必要的功能
    + [例子: 清理了接口里不需要返回的数据(filename)](https://github.com/liijunwei/char_detector/commit/68cccb818c6659f3043ccbc34c3df06ca3659edd)
    + [例子: 清理了测试用例里, 对匹配到的行里内容的断言](https://github.com/liijunwei/char_detector/commit/7c0fa5442233f795a5e7024817cc6abe78fc44a4)
    + [例子: 拒绝扫描一个目录里所有的文件的feature, 借助 find命令和xargs或parallel命令实现](https://github.com/liijunwei/char_detector/commit/85cd8a24792ed5a7a9dedf5fac8db4aecf2cde97)
+ 虽然要实现的功能是很简单的, 但是沿途有太多的诱惑(实现其他功能, 实现得很复杂, 做点别的更有趣的事儿, 玩会儿游戏?), 让这个工具好用是要下功夫的
+ 之前读到过王垠的博客, 里面讲到 ["很多人以为看大型项目可以提升自己，而没有看到大型项目不过是几十行核心代码的扩展，很多部分是低水平重复。"](https://www.yinwang.org/blog-cn/2020/02/05/how-to-read-code), 这次有了实际的体会
    + `CharDetector`这个应用很简单, 核心代码就只有[10行左右](https://github.com/liijunwei/char_detector/blob/18f759c987dfd354fa509767f7c025572b942998/lib/char_detector/engine.rb#L11-L22), 它完成的事情很简单, 它的实现很简单, 这是它简单的方面
    + 相应的, 他也有复杂的一面, 我理解的是:
        1. 从无到有是困难的
        2. 从无到有的过程中, 做得越多, 对问题越了解, 越接近最初的目标, 此时想法(idea)会源源不断的冒出来(昨晚甚至有点失眠...), 那些想法都是**诱惑**, 一不小心就会走偏, 没能做出最初想要的工具, 或者工具做的太复杂, *实现了臆想出的需求*...
+ 这个工具怎么能和其他(linix)工具配合使用?
+ 我想要实现的功能, 都是必须的吗? 能不能用已有的工具替代?
+ 即使最初一无所知, 甚至不知道问题是什么, 但是在学习过程中, 慢慢会有能力把问题定义清楚的, 一定要不断问自己 "问题到底是什么", 不然就是没有目的的瞎转

### 感觉有价值的的参考资料

+ [Make awesome command line apps with ruby by Dave Copeland](https://www.youtube.com/watch?v=1ILEw6Qca3U&t=495s)
    + 提醒我好的命令行工具需要学习"the unix way", 注意把自己的事做好, 注意和其他程序配合
        + greable
        + cutable
        + exit
        + messaging
+ [关于字符编码，你所需要知道的（ASCII,Unicode,Utf-8,GB2312…）](http://www.imkevinyang.com/2010/06/%E5%85%B3%E4%BA%8E%E5%AD%97%E7%AC%A6%E7%BC%96%E7%A0%81%EF%BC%8C%E4%BD%A0%E6%89%80%E9%9C%80%E8%A6%81%E7%9F%A5%E9%81%93%E7%9A%84.html)
    + 信息里大, 也好懂, 值得反复多读几遍
+ [POSIX Bracket Expressions](https://www.regular-expressions.info/posixbrackets.html)
    + 手册, 可以多看看; 很多正则表达式不要手写了, 都已经有标准的分类了
+ [flog: 找出应用里里最折磨人的代码](https://github.com/seattlerb/flog)
    + 用这工具或类似的指标工具审视自己写的代码, 不要过于自信
    + 读它的源码, 借鉴了一些它实现cli的思路
    + 但是也拒绝了一些东西(里面用了很多他们自己实现的东西, 很小众, 不好动 比如 ruby_parser/path_expander)
        + ruby_parser 貌似是 flog的核心, 有空仔细看看

PS. 越写越长可不是好习惯!

### 回答最初问题

WIP




