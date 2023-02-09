---
title: review and remove unused gems
date: 2023-02-09 11:21:21
tags:
    - ops
    - cleanup
---

## review and remove unused gems

```bash
bundle list --without-group dev development staging test
bundle list --only-group default production

tldr du
tldr sort

for dir in $(bundle list --only-group default production --paths); do du -shk $dir ; done | sort -nr
```

