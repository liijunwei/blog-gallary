---
title: ruby-script-encoding
date: 2022-07-13 00:13:16
tags:
  - ruby
---

ref: https://ruby-doc.org/core-3.0.0/Encoding.html#class-Encoding-label-Script+encoding

终于知道了ruby script里encoding这个magic comment是什么作用了

> All Ruby script code has an associated Encoding which any String literal created in the source code will be associated to.

> The default script encoding is Encoding::UTF_8 after v2.0, but it can be changed by a magic comment on the first line of the source code file (or second line, if there is a shebang line on the first).
> The comment must contain the word coding or encoding, followed by a colon, space and the Encoding name or alias:

> The `__ENCODING__` keyword returns the script encoding of the file which the keyword is written:

+ file1.rb
```ruby
# encoding: ASCII-8BIT

p "hello".encoding # #<Encoding:ASCII-8BIT>
p __ENCODING__ # #<Encoding:ASCII-8BIT>
```

+ file2.rb
```ruby
# encoding: UTF-8

p "hello".encoding # #<Encoding:UTF-8>
p __ENCODING__ # #<Encoding:UTF-8>
```

