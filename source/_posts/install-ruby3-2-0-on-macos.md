---
title: install ruby-3.2.0 on macos
date: 2023-01-01 11:28:14
tags:
  - ruby
---

## Background

+ I prefer rvm over rbenv, maybe I should use rbenv insead ):
    + [rvm/rvm: Ruby enVironment Manager (RVM)](https://github.com/rvm/rvm)
    + [rbenv/rbenv: Manage your app's Ruby environment](https://github.com/rbenv/rbenv)
+ `rvm list known` not showing the latest ruby version
+ `rvm instal 3.2` fails
+ `rvm fix-permissions` not working for "\_rvm_log_dotted:23: permission denied" error
+ I noticed these two pieces of information
    + ["NOTE: Even though this is all *known* rubies, RVM can install many more rubies not listed :)"](https://rvm_io.global.ssl.fastly.net/rubies/list)
    + ["Because https://cache.ruby-lang.org/pub/ruby/3.2/ has no "Ruby-Preview.tar.gz" file in the directory"](https://github.com/rvm/rvm/issues/5224#issuecomment-1272294133)
    + which means it should be able to install any ruby version listed in [pub/ruby/](https://cache.ruby-lang.org/pub/ruby/) with rvm

## Steps

```bash
rvm reinstall "ruby-3.2.0" --with-openssl-dir=`brew --prefix openssl@3` # not ok, [ruby don't support openssl 3 yet.](https://github.com/ruby/openssl/issues/369)

brew uninstall openssl@3
brew reinstall openssl@1.1

# new shell
rvm reinstall "ruby-3.2.0" --with-openssl-dir=`brew --prefix openssl@1.1` --disable-binary # ok
```

## Other ref

+ [_rvm_log_dotted:23: permission denied: | Tinyfeng's blog](http://blog.tinyfeng.com/blogs/65)
