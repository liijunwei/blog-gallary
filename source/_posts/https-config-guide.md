---
title: https-config-guide
date: 2021-11-06 16:03:50
tags: https
---

注: 这里主要记录`怎么申请免费的SSL证书 `和 `在nginx上配置HTTPS`

主要的参考文档: [阿里云.SSL证书服务](https://help.aliyun.com/product/28533.html)

起因: 调试 `小米小爱开放平台` 里的 `服务端口类型` 需要https接口

### 前置要求

+ 一个阿里云账号
+ 一个已备案的域名
+ 一台ECS(Ubuntu)
+ 一个用nginx代理的http服务

### 申请SSL证书

+ 进入 `阿里云SSL证书 控制台`
+ `SSL证书`
+ `免费证书` (测试, 个人试用场景, 商用的不在这里讨论)
+ `立即购买`
+ 填入必要信息即可
+ 在 `状态` 那里可以看到证书的签发进度
+ 签发后, 点击`下载`

### 上传 key和pem

```sh
scp yourdomain_nginx.zip youserver:/home/
```

### 检查 ECS的安全组

+ 进入 `阿里云ECS控制台`
+ 进入ECS实例控制台
+ 进入 `安全组` tab, 进入安全组配置
+ 检查 安全组的入方向是否允许 443 端口的访问, 如果没有, 点击 `快速添加`, 选择`https`即可

### 检查 ECS的防火墙配置

```sh
sudo ufw status
sudo ufw allow https

# 本机测试端口是否已开放
telnet yourdomain 443
```

### 配置nginx

[在Nginx（或Tengine）服务器上安装证书](https://help.aliyun.com/document_detail/98728.html?spm=5176.b657008.help.dexternal.7b141b48cEqwAp)

```
# http请求转为https请求
server {
  listen 80;
  server_name yourdomain;
  rewrite ^(.*)$ https://${server_name}$1 permanent;
}

server {
  listen 443;
  ssl on;
  server_name yourdomain;

  ssl_certificate     /etc/nginx/cert/6556112_yourdomain.pem; # 证书pem 所在的路径
  ssl_certificate_key /etc/nginx/cert/6556112_yourdomain.key; # 证书key 所在的路径
  ssl_session_timeout 5m;

  ...
}
```

配置后, 需要reload nginx服务

```sh
sudo nginx -t
sudo nginx -s reload
```

### 验证https生效

```sh
curl -I http://yourdomain  # 应该返回 `301 Moved Permanently`
curl -L http://yourdomain  # 应该正常访问(200)
curl -I https://yourdomain # 应该正常访问(200)
```

### You're All Set !!!

