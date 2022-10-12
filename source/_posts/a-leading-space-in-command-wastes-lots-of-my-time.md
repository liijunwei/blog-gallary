---
title: A leading space in command wastes lots of my time
date: 2022-10-05 18:42:55
tags:
  - linux
---

This one doesn't have a TL;DR

## Background

+ I learned to write tools for my own from [this repo](https://github.com/ery/suitup)
+ I heard career advice of ["Spend 30 minutes each day improving something about your process (automate the thing you repeat the most) or environment (editor, shell, OS, etc)."](https://www.zenspider.com/ruby/2012/09/career-advice.html)
+ I'm using "Oh My Zsh", and have [my own omz plugin](https://github.com/liijunwei/omz-git), the one causing issue is another private repository

## What I did

+ I wrote two specific shell aliases for rspec, `re` for running specs without error backtraces, `ree` for with error backtraces
```bash
alias re="DISABLE_SPRING=1 bundle exec rspec --format=progress --no-profile"
alias ree="DISABLE_SPRING=1 bundle exec rspec --format=progress --no-profile --backtrace"
```

+ One day, I found it looks better if I change them to this(alignment):
```bash
alias re=" DISABLE_SPRING=1 bundle exec rspec --format=progress --no-profile"
alias ree="DISABLE_SPRING=1 bundle exec rspec --format=progress --no-profile --backtrace"
```
![](./images/a-leading-space-in-command.png)

+ Later, I forgot the change
+ Somehow, I find the frequently used `re` command never got remembered by type re and press the up arrow(which acts as searching from history in OMZ)

## Trouble shooting

+ I didn't think too much about what I'v recently changed
+ I thought I screwed up my OMZ environment, so I keep creating new terminal session, didn't work
+ I thought my history file is too big, so I cleared the history file, didn't work
+ I put this issue aside for a few days without any solution, suffering from typing/copy-paste the frequently used `rspec` commands again and again
+ A few days later, I can't stand it anymore, and at this time, I found that only that `rspec` related command won't be remembered by history!(still didn't connect to previous changes...)
+ Until second day when I tried to optimize my OMZ plugin, I noticed the git history: THERE IS A LEADING SPACE IN MY RSPEC ALIAS!!! because of the `code alignment`

## The reason

+ I learned the trick about 2 years ago from a youtuber "Engineer Man": [A leading space in command line cause it won't be written into history](https://github.com/engineer-man/youtube/blob/dfb41997c949509e42b8fb64a918cbed7dc61f2b/058/commands.sh#L11)
    + https://www.youtube.com/watch?v=Zuwa8zlfXSY&t=384s
    + sadly I can't google it out the name of this feature...
+ To be honest, I almost got no chance to use that trick, only used once time on production server(didn't mean to hack xD)
+ But I remember the tick and it's this trick and the coincidence that caused my alias not written into history!

## The fix

+ Remove the leading space in shell alias, simple enough

## Learnings

+ Be aware of your changes, make sure you fully understand the output
+ When unexpected behavior happened, checkout your changes first
    + Maybe ["SRE has found that roughly 70% of outages are due to changes in a live system."](https://sre.google/sre-book/introduction/) applies to my little system too...
+ Don't tolerate the inconvience for too long, find it, solve it
+ Perform tests after changes even for my own tools

