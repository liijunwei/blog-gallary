---
title: amg-code-sharing
date: 2021-09-12 17:35:16
tags:
  - AMG
---

**AMG: Alert Management Gateway**

20210911做了一次AMG的核心代码分享, 为使用java重写做准备
参与的人主要是OSS组同事

AMG本质上, 是仿照[Pagerduty](https://www.pagerduty.com/)做的


### AMG做的几件事

接收告警
建任务, 跟踪进度
告警通知

### 代码入口

SOURCE            | TRIGGER_WAY | PURPOSE           | CODE_ENTRY
------------------|-------------|-------------------|---------------------------------------------
阿里云监控.指标   | MQ          | 告警触发/再次触发 | script/polling.rb
阿里云监控.站点   | MQ          | 告警触发          | script/polling.rb
华为云监控        | 回调        | 告警触发/再次触发 | app/controllers/hw_alert_controller.rb
北斗监控          | 回调        | 告警触发/再次触发 | app/controllers/beidou_alert_controller.rb
北斗监控.事件     | 回调        | 告警触发          | app/controllers/beidou_alert_controller.rb
AMG               | 定时任务    | 告警升级          | script/check_alert_escalations.rb
JIRA7             | 回调        | 告警认领/处理通知 | app/controllers/jira7_controller.rb
手机              | 回调        | 手机认领          | app/controllers/incidents_controller.rb
腾讯云监控        | 回调        | 告警触发/再次触发 | app/controllers/tencent_alert_controller.rb


### 主要功能

FUNCTIONALITY  | IS_ESSENTIAL  | CODE_ENTRY
---------------|---------------|-----------------------------------------------------------
指标告警       |       Y       | 回调/定时轮询(script/polling.rb, *\_alert_controller.rb)
站点监控告警   |       Y       | lib/site_monitor/message_handler.rb
电话告警       |       Y       | lib/call_center/*.rb
告警升级       |       Y       | script/check_alert_escalations.rb
告警记录       |       Y       | lib/jira/*.rb
告警统计       |       N       | script/import/*.rb
拓扑监控数据源 |       N       | lib/tuopu_source/*.rb
手机认领       |       N       | app/controllers/incidents_controller.rb
告警分级       |       Y       | lib/alert_message_handler/*.rb
历史原因       |       Y       | lib/history_reason/*.rb


### 架构关系

![](./AMG架构-V20210202.png)

### 时序图

![](./AMG时序图-V20210906.png)

### 最大的函数做了什么?

handler数量 = (阿里云 华为云 腾讯云) x (紧急 重要 次要 提示) = 16+

函数: xxx_handler

```bash
+ 建 event
+ 建 alert

+ 建 incident
    + 判断 是否去重
    + 建 jira

+ 如果重复 那么返回

+ 判断 是否是再次告警
+ 判断 当前jira任务的状态
+ 拓扑监控数据源
+ 分析历史原因
+ 打电话
+ 告警沉默时间
+ 向Oncall群发消息
+ 向告警订阅者发消息
+ 回调北斗, 通知消息已发送
```
> "代码就是设计文档, 顺便让计算机执行"

### 函数重构的思路

```bash
+ 初始化数据
    + 建 event
    + 建 alert
    + 建 incident
    + 判断 是否去重
    + 建 jira

+ 通知
    + (先写: 如果xxx, 那么不通知, 再处理通知的逻辑)
    + 如果告警沉默, 那么不通知
    + 判断 是否是再次告警
    + 判断 当前jira任务的状态
    + 打电话
    + 向Oncall群发消息
    + 向告警订阅者发消息

+ 统计数据
    + 拓扑监控数据源
    + 分析历史原因
```

