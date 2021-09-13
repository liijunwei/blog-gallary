---
title: custom-omz-plugins
date: 2021-09-09 21:03:51
tags:
  - shell
  - git
  - oh-my-zsh
---

> `命令行+编辑器` 的使用受雷哥影响, 感谢指导. [**ref: REPO**](https://github.com/ery/suitup)

今天整理了一下常用的git相关的helper-functions, 原本是放在`notebook`的某个目录里, 每增加一个, 就去 `$HOME/.zshrc`里source一下

虽然脚本很好用, 但是每次去修改`$HOME/.zshrc`太蛋疼了

## Old way

```bash
source $HOME/Documents/notebook/learn/git/custom_git_scripts.sh
source $HOME/Documents/notebook/learn/git/git.open.web.commit.page.sh
source $HOME/Documents/notebook/learn/git/git-clone-and-cd-into.sh
source $HOME/Documents/notebook/learn/git/git.dfff.enhance.sh
source $HOME/Documents/notebook/learn/git/git.open.repo.in.browser.sh
```

使用oh-my-zsh的插件功能, 结合github管理这些插件 [__欢迎拿去用__](https://github.com/liijunwei/custom-omz-plugins)

## Better way

```bash
cd $HOME/.oh-my-zsh/custom/plugins/
git init
git add .; git commit -am 'Init';
git remote add origin git@github.com:liijunwei/custom-omz-plugins.git
git push

# Add plugin in $HOME/.zshrc
plugins=(
  git
  gitfast
  zsh_reload
  zsh-autosuggestions
  git-auto-fetch
  demo    # hey there
  git-ljw # and there
)

source $HOME/.zshrc
```
And... enjoy your custom functions~


## Thought

做正确的事, 找到最佳实践, 并且遵守最佳实践.

> Your life will be a lot easier

