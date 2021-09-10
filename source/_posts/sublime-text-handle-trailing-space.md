---
title: sublime-text-handle-trailing-space
date: 2021-09-10 11:41:47
tags:
  - sublime
---

Ref: [Bind shortcut to command palette command?](https://stackoverflow.com/questions/11834652/bind-shortcut-to-command-palette-command)

1. 使用 sublime 自带的功能 `Trim Trailing White Space` (cmd+shift+p -> type in "trim" -> enter)

2. 安装插件 [Highlight Trailing Whitespace](https://github.com/p3lim/sublime-highlight-trailing-whitespace)

3. 找出清除最后的空格的命令: sublime -> view -> "show console" -> type in "sublime.log_commands(True)" -> cmd+shift+p -> trim -> enter -> record the command -> setup the keybindings

```json
// sublime -> preference -> keybindings
  { "keys": ["ctrl+shift+t"], "command": "trim_trailing_white_space" }
```
