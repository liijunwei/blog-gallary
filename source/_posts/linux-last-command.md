---
title: linux-last-command
date: 2021-09-29 21:54:54
tags:
  - shell
---


shell 里, `!!` 表示上一个命令

刚发现一个结合 `watch` 的好的用法

```bash
➜  ~ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            934M     0  934M   0% /dev
tmpfs           192M  4.8M  187M   3% /run
/dev/vda1        40G  9.2G   29G  25% /
tmpfs           956M     0  956M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           956M     0  956M   0% /sys/fs/cgroup
tmpfs           192M     0  192M   0% /run/user/1000
➜  ~ watch "!!" # 注意要用 双引号括起来
➜  ~ watch "df -h"
```

基本思路就是, 先输入单个命令, 再用 `watch "!!"` 去自动运行...

非 常 好 用 ;D
