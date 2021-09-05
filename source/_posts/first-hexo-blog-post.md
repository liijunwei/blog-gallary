---
title: first-hexo-blog-post
date: 2021-09-04 19:02:06
tags:
  - hexo
  - first-time
---

### 今天开始使用hexo公开自己的文章

还有很多问题没解决掉, 慢慢来

### 部署步骤

+ 本地启动安装hexo

```bash
sudo npm install hexo-cli -g
```

+ 本地用hexo新建一个项目

```bash
hexo init blog
cd blog
npm install
hexo server
```

+ 安装部署工具

```bash
npm install hexo-deployer-git
```

+ 修改配置

主要是 `_config.yml` 里的deploy部分

```yaml
deploy:
  type: git
  repo: webuser@xiaoli:/home/webuser/my_git_repo/blog-gallary.git
  branch: master
```

+ 在VPS上新建一个 bare git仓库(下面称为 bare-git-repo)(使用github也可以, 一样的)

```bash
ssh webuser@xiaoli
cd /home/webuser/my_git_repo
git init --bare blog-gallary.git
```

+ 本地提交代码(不一定提交到到github, 本地存着也可以)

+ 使用 hexo deploy, 把代码部署到VPS的 bare-git-repo

```bash
hexo clean && hexo deploy
```

+ 在VPS上的 /srv/www 目录下clone bare-git-repo

```bash
ssh webuser@xiaoli
cd /srv/www
git clone file:///home/webuser/my_git_repo/notebook.git
```

+ 配置dns解析


+ 配置nginx

基本配置

```bash
cat /etc/nginx/sites-enabled/production.blog.conf

server {
  listen 80;
  server_name blog.bxzy.top;
  root /srv/www/blog-gallary;
  index index.html;
}
```

+ 访问 blog.bxzy.top

### Basic Workflow

```bash
# local
cd ~/OuterGitRepo/blog-gallary
hexo new title_xxx
git add .; git commit -am 'Added blog post title_xxx.'
hexo clean && hexo deploy && ssh webuser@xiaoli "cd /srv/www/blog-gallary && git pull"

# visit
http://blog.bxzy.top
```
