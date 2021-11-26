---
title: sso-using-ssh-agent
date: 2021-11-26 21:36:07
tags:
  - ssh
---

终于搞懂了 ssh-add ssh-agent ssh -A user@host 实现的SSO

https://www.ssh.com/academy/ssh/agent

```sh
eval `ssh-agent` && ssh-add # 启动 ssh-agent 并且把当前用户的 key加到agent里

ssh -A user@host_a # 如果sshconfig里没有 `ForwardAgent yes`
ssh    user@host_a # 如果sshconfig里  有 `ForwardAgent yes`

ssh-add -l # 检查本机的key是否被带到了机器上

ssh user@host_b
```

假设 本机   可以ssh到 host_b
假设 host_a 不可以ssh到 host_b

使用上面的方法, 可以实现在 host_a 上, 直接ssh登录 host_b

假设 本机     有权限拉代码库A的代码
假设 host_a 没有权限拉代码库A的代码

使用上面的方法, 可以实现在 host_a 上, 拉代码库A的代码

