# blog-gallary

### Welcome to my blog post

http://blog.bxzy.top

### my github page

```bash
echo "hello :-)"
```

### theme

这几个挺好看的

+ [clean-blog](https://github.com/klugjo/hexo-theme-clean-blog)
+ [anodyne](https://github.com/klugjo/hexo-theme-anodyne)

### deploy

#### setup
```sh
# remote
blog_bare_repo="/srv/www/blog-gallary.git"

mkdir $blog_bare_repo
cd $blog_bare_repo
git init --bare

mkdir /srv/www/blog-gallary
git remote add origin file://$blog_bare_repo

# local
rm -rf .deploy_git && hexo clean && hexo deploy
```

#### afterwards

bin/deploy
thought
thought -e
thought "xxx"

