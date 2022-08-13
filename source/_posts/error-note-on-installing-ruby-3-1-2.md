---
title: error note on installing ruby 3.1.2
date: 2022-08-13 22:51:34
tags:
  - ruby
---

### The error

```bash
$ rvm install 3.1.2

Error running ' CFLAGS=-O3 -I/usr/local/opt/libyaml/include -I/usr/local/opt/libksba/include -I/usr/local/opt/readline/include -I/usr/local/opt/zlib/include -I/usr/local/opt/openssl@1.1/include -I/usr/local/opt/libyaml/include -I/usr/local/opt/libksba/include -I/usr/local/opt/readline/include -I/usr/local/opt/zlib/include -I/usr/local/opt/openssl@1.1/include LDFLAGS=-L/usr/local/opt/libyaml/lib -L/usr/local/opt/libksba/lib -L/usr/local/opt/readline/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/openssl@1.1/lib -L/usr/local/opt/libyaml/lib -L/usr/local/opt/libksba/lib -L/usr/local/opt/readline/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/openssl@1.1/lib ./configure --prefix=/Users/lijunwei/.rvm/rubies/ruby-3.1.2 --disable-install-doc --enable-shared',
please read /Users/lijunwei/.rvm/log/1660401863_ruby-3.1.2/configure.log
There has been an error while running configure. Halting the installation.

$ cat /Users/lijunwei/.rvm/log/1660401863_ruby-3.1.2/configure.log
__rvm_log_dotted:23: permission denied:
```

### The keyword to search

"__rvm_log_dotted:23: permission denied:"


### The solution

https://github.com/rvm/rvm/issues/5055#issuecomment-815036429

```
rvm install 3.1.2 --with-gcc=clang
```
