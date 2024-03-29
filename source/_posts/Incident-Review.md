---
title: Incident Review
date: 2023-04-12 23:39:40
tags:
  - 反思
---

今天因为我的失误导致了一次小故障，持续大概一小时才被发现，影响10多个用户，需要修几十条数据(粗略估计)

这是在公司因为我导致的第二次问题，有必要把反思记录一下

## 第1次问题(2022年底)

功能开发完成，QA内部测试完成，但是隔了有一段时间才真正在生产环境启用，导致功能开关的影响范围没有完全理清，和另一个功能开关的开启产生了干涉，问题持续了近10个小时才被发现，导致有几千条数据异常；最后只得花了很多精力从日志里捞数据，修数据，非常麻烦

当时反思有这几点原因：

1. 功能内测结束后没有重置功能开关
2. 打开功能开关之前没有检查功能开关的状态，没有考虑到功能之间可能产生干涉
3. 一段时间内，同时在处理的事情有点多了(WIP数量有点多)，精力太过分散，review不到位
4. 对生产环境变更缺少敬畏心


## 第2次问题(2023-04-12)

有一个较大的任务，是给多个业务场景添加`source_type`和`source_id`, 以便于数据查询和统计；最近到了收尾阶段，有几个场景的改动在其他团队阻塞了近1个月，为了不完全被阻塞，leader和我先把后续的验证环节先做好了，准备内测

今天刚刚开启内测的开关，因为考虑不周，导致了空指针异常

直接原因是遗漏的几个场景没有部署，导致对应的`source_type`和`source_id`为空

根本原因是自己的疏忽，有这么几点
1. 测试用例里，应该捕获到这个问题，但是实际上没有，这是偷懒导致的
2. 在有几个场景被阻塞的前提下，为了不完全被阻塞，开始做其他的事前，没有想清楚哪些事是需要注意的，多想一步，就可以想得到之后的测试用例要着重关注它们
3. 修改不熟悉的代码时，不够细心，最基本的为空的情况被自己遗漏了
4. “后续的验证环节”这部分代码，不应该影响业务流程，这里最保险的方法是加上异常捕获(fail-safe)；虽然捕获一个general的异常是糟糕的实践，但在这个场景下其实是很合适的，我因为心底拒绝这种实践，所以完全忽略了这种做法
5. 开启开关后，对生产环境的监控疏忽了，竟然是近1个小时后才从告警群里发现有问题...
6. 对生产环境变更缺少敬畏心

## 反思

1. 无论业务是否关键，变更前都要想清楚怎么监控，怎么减少错误出现的可能；如果一定不能出错，fail-safe的做法就是必要的
2. 对生产环境变更要有敬畏之心
3. limit WIP, 把事情做好，不要一下给很多事开头，不停的在很多事之间切换
4. 常识: 多想想如果为空会怎么样; 自信想了一下，没考虑到这个，和写代码的方式也有关，方法定义的方法调用的地方相隔太远，没有有意识的去专门检查，如果他们离得近，发现他们的概率会提升很多
5. 如果想不清楚，就先不要开启，就先不要发布；和生产环境相关的变更，头脑不清楚的时候不要动
6. 这两次问题影响范围不算太大，算是教训；如果不注意，以后犯更大错误的可能性更高；一定要多培养好习惯，发现和克服坏习惯

