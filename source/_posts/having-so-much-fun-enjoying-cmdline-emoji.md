---
title: having-so-much-fun-enjoying-cmdline-emoji
date: 2021-12-23 18:25:48
tags:
  - fun
  - terminal
---

> 命令行里加个小表情足以愉悦自己
> 当git工作区不是"working tree clean"状态时 放出小表情

![](./cmdline-emoji.png)


实现方法:

```sh
# $HOME/.zshrc
# env: MacOS

ZSH_THEME="ys"
function parse_git_dirty {
  [[ -d .git ]] && [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "🤣"
}
export PS1='%n@%m:%1~%$(__git_ps1 " (%s)")$(parse_git_dirty)$ ' # with git branch, 配合 iterm的(smart selection)
```
