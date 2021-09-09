---
title: custom-omz-plugins
date: 2021-09-09 21:03:51
tags:
  - shell
  - git
  - oh-my-zsh
---

今天整理了一下常用的git相关的helper-functions, 原本是放在`notebook`的某个目录里, 每增加一个, 就去 `~/.zshrc`里source一下

虽然脚本很好用, 但是每次source很蛋疼

```bash
# old way
source ~/Documents/notebook/learn/git/custom_git_scripts.sh
source ~/Documents/notebook/learn/git/git.open.web.commit.page.sh
source ~/Documents/notebook/learn/git/git-clone-and-cd-into.sh
source ~/Documents/notebook/learn/git/git.dfff.enhance.sh
source ~/Documents/notebook/learn/git/git.open.repo.in.browser.sh
```

使用oh-my-zsh的插件功能, 结合github管理这些插件 [__欢迎拿去用__](https://github.com/liijunwei/custom-omz-plugins)

```bash
# Better way
cd ~/.oh-my-zsh/custom/plugins/
git init
git add .; git commit -am 'Init';
git remote add origin git@github.com:liijunwei/custom-omz-plugins.git
git push

# Add plugin in ~/.zshrc
plugins=(
  git
  gitfast
  zsh_reload
  zsh-autosuggestions
  git-auto-fetch
  demo    # hey there
  git-ljw # and there
)

source ~/.zshrc

# And... enjoy your custom functions~

```

体会: 做正确的事, 找到最佳实践, 并且遵守最佳实践, Your life will be a lot easier.

