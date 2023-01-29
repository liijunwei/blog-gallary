---
title: Find unused local variables in ruby project
date: 2023-01-29 21:12:34
tags:
  - ruby
  - tool
---

Inspired by [SublimeLinter plugin for ruby, using ruby -wc](https://github.com/SublimeLinter/SublimeLinter-ruby)

```bash
parallel "ruby -wc {}" ::: $(find . -name \*.rb) 1> /dev/null
```

## Known issue

it only detects local variables for "warning: assigned but unused variable - xxx"

not working for instance variables

probably work with [unused-code/unused](https://github.com/unused-code/unused) to detect other unused `tokens`

### unused

```bash
# https://github.com/universal-ctags/homebrew-universal-ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install unused --with-mimalloc

alias ctags='/usr/local/bin/ctags'

# go to project working dir
ctags --recurse . && ls -lh tags && unused
```
