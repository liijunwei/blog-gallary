---
title: editor-and-terminal-autorun
date: 2021-09-16 23:43:07
tags:
  - terminal
  - sublime
---

__本篇分享怎么用编辑器和命令行打造一个"自动运行并显示结果"的调试环境__

## 现象

学语言的时候, 总是需要敲一段示例, 然后运行一次(IDE的按钮, 或者用命令行)

这个过程很重复, 很机械, 刚好符合自动化的条件...

## 准备

+ sublime/或者其他编辑器(无所谓)
+ unix-like命令行(windows下应该有类似的命令)
+ `watch 命令`

## `watch 命令`

```bash
lijunwei@bxzy:lua(master)$ tldr watch

  watch

  Execute a program periodically, showing output fullscreen.

  - Repeatedly run a command and show the result:
    watch command

  - Re-run a command every 60 seconds:
    watch -n 60 command

  - Monitor the contents of a directory, highlighting differences as they appear:
    watch -d ls -l
```

watch 命令的含义很直观, 就是**观察命令执行的结果**

我最常用的就是 `-d` 和 `-n` 参数了

+ `-d` 表示 如果命令的输出不同了, 展示出来
+ `-n` 表示 每几秒执行一次 某条命令(这个命令和在终端里输入命令是一样的, 只是需要注意有的时候需要`上下文`, 环境变量等)

## 开始

+ 以调试lua脚本为例
+ shell脚本也可以
+ java程序也行...
+ ...发挥想象力就行, 重点是**思路**

```bash
cd $HOME/Desktop/temp
mkdir lua
cd lua
touch learn.lua
watch -d -n 1 "lua learn.lua"

# 屏幕分两半, 左边放浏览器, 右上放编辑器, 右下放命令行...

# 用编辑器打开当前工作目录
subl .

# 之后只需要在编辑器里输入练习的示例就行
```
> OK 大功告成

![](./flow-learn.png)

