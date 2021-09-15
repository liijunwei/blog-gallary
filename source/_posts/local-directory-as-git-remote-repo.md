---
title: local-directory-as-git-remote-repo
date: 2021-09-05 22:51:37
tags:
  - git
---

### 为什么不用github

1. fetch/push速度慢
2. 练习git操作, 没必要专门建一个github仓库
3. 练习git操作, 本地的repo操作起来速度飞快

### local repo on my mac

```bash
alias local_repo='cd $HOME/local.repo/api-provider.git'
```

### 将本地目录当做git仓库...步骤

1. 本机, 在某个目录里

```bash
# 会在当前目录下, 新建一个 test.git 的bare仓库
$ git init --bare test.git
```

2. 客户端: 初始化仓库或者使用已有的git仓库

```bash
# 如果 origin已存在, 可以换个别的名字(例如 demo_origin), 只是推送代码的时候要注意 向demo_origin推
$ git remote add origin file://$HOME/local.repo/api-provider.git # local directory
```

如果就想用origin, 那么可以先删掉原先的, 再添加origin

```bash
$ git remote remove origin
```

3. 客户端可以推送代码了... `git push`

4. 克隆

```bash
$ git clone file:///home/webuser/my_git_repo/notebook.git
```

### 扩展: 可以把ECS作为自己的git仓库

原理和上面类似
