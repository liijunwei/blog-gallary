#### Welcome

http://blog.bxzy.top

#### deployment
```sh
# setup ECS nginx config
ll /etc/nginx/sites-enabled/production.blog.conf

# setup static file folder
ssh webuser@xiaoli
mkdir -p /srv/www/blog-gallary

# sync static files
make sync
```

#### afterwards

[thougut util](https://github.com/liijunwei/custom-omz-plugins/blob/main/thought/thought.plugin.zsh)

```sh
thought
thought -e
thought "xxx"
thought -i
```
