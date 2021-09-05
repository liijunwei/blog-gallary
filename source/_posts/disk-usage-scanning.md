---
title: disk.usage.scanning
date: 2021-09-05 23:35:41
tags:
  - bash
---

####usage:

```bash
sudo -s
vi /tmp/disk_scan.sh
(nohup /bin/bash /tmp/disk_scan.sh >> /tmp/disk_clean.log 2>&1 &)
```

```bash
#!/bin/bash

function notice_admin(){
    # Wechat Work robot url
    local admin_qywx_robot="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=90d9b623-826c-xxxx-xxxx-xxxxxxxxxxxx"
    local program="$1";
    local message="$2";
    local host=$(hostname);

    curl -s $admin_qywx_robot \
   -H 'Content-Type: application/json' \
   -d "
   {
        \"msgtype\": \"text\",
        \"text\": {
            \"content\": \"$host $program \n $message.\",
            \"mentioned_list\":[\"\"]
        }
   }"
   echo;
}

function timestamp() {
  date "+%Y-%m-%d %H:%M:%S"
}

function echo_with_timestamp() {
  local msg=$1
  echo "$(timestamp) $msg"
}

dir_path="/"
echo_with_timestamp "Disk usage scanning.start $dir_path"

result=$(du -ch --exclude=/mnt "$dir_path" --max-depth=3 | sort -n | grep "G\s")
result="${result:-BigFileNotFound}"

echo_with_timestamp "Disk usage scanning.end $dir_path"
echo "$result"

notice_admin "Disk usage scanning" "$result"
```
