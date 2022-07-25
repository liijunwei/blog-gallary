---
title: How to read or debug rubocop source code
date: 2022-07-25 19:43:01
tags:
  - ruby
  - methodology
  - trick
---

Actually, this is a general trick to understand any code: Find a concrete question -> get source code -> add breakpoints -> mess around -> observe the stacktrace...

## Solid example

rubocop codebase is huge, what if I want to know how it works by observing one cop?

follow the steps bellow:

1. clone the repo and cd into repo
2. Run `bundle install`
3. add breakpoint in source code, e.g.: add `require 'pry'; binding.pry` to [lib/rubocop/cop/lint/shadowed_exception.rb](https://github.com/rubocop/rubocop/blob/4537491f6e58f09d619441bc44db129c41156131/lib/rubocop/cop/lint/shadowed_exception.rb#L54)
4. find the executable of the gem, in this case `exe/rubocop`
5. Run `exe/rubocop --only Lint/ShadowedException tmp/shawdowed_exception.rb` and mess around with that breakpoint
6. Run `caller.grep /rubocop/` to see stacktrace

btw, go ahead to see spec/tests is also a good option.

Have fun reading source code
