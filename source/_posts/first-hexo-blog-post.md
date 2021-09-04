---
title: first-hexo-blog-post
date: 2021-09-04 19:02:06
tags: [hexo, first-time]
---

### 今天开始使用hexo公开自己的文章

还有很多问题没解决掉, 慢慢来

### 部署步骤

+ 本地启动安装hexo



+ 本地用hexo新建一个项目



+ 安装依赖



+ 安装部署工具(hexo-deployer-git)



+ 修改配置



+ 在VPS上新建一个 bare git仓库(下面称为 bare-git-repo)(使用github也可以, 一样的)



+ 本地提交代码(不一定提交到到github, 本地存着也可以)



+ 使用 hexo deploy, 把代码部署到VPS的 bare-git-repo



+ 在VPS上的 /srv/www 目录下clone bare-git-repo



+ 配置dns解析



+ 配置nginx



+ 访问


### Basic Workflow

```bash
# local
cd ~/OuterGitRepo/blog-gallary
hexo new title_xxx
git add .; git commit -am 'Added blog post title_xxx.'
hexo clean && hexo deploy

# VPS
cd /srv/www/blog-gallary && git pull # TODO 这步自动化后就比较舒服了

# visit
http://blog.bxzy.top
```
