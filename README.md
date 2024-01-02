#### Welcome

http://blog.bxzy.top

#### nginx conf

```
server {
  listen 80;
  listen [::]:80;
  server_name blog.bxzy.top;

  root /home/me/blog/;
  index index.html index.htm;

  location / {
    try_files $uri $uri/ =404;
  }
}
```

fix nginx permission issue
```bash
sudo tail -f /var/log/nginx/*.log

sudo -u www-data stat /home/me/blog
sudo gpasswd -a www-data me
sudo -u www-data stat /home/me/blog
sudo nginx -s reload

# visit domain again
```
