---
title: what must be clear while upgrading
date: 2023-08-02 22:43:38
tags:
  - rollout
  - application dependency upgrade
---


### Given

- new version `is compatiable with`     old version
- old version `is NOT compatiable with` new version

### Then

- rollout(old -> new) or rollback(new -> old)
    - case#1 new produce -> new consume OK
    - case#2 new produce -> old consume ERROR
    - case#3 old produce -> new consume OK
    - case#4 old produce -> old consume OK

### Review

1. if retry could make case#2 work, then it's ok and expected, otherwise we need to figure out how to do the upgrade carefully
2. if cache object deserilization is included, better consider using a fresh new cache key(sth like version number) to make sure new version won't load the outdated version of cache data

