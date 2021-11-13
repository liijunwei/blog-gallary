---
title: My First TamperMonkey Userscripts
date: 2021-11-13 22:26:57
tags:
  - javascript
  - efficiency
---

### [Youtube Tutorial](https://www.youtube.com/watch?v=U4dSWJFIQ0A)

### [Tampermonkey](https://www.tampermonkey.net/)

Tampermonkey 是一款 浏览器插件


### 需求来源

空余时间在B站学习C语言, 偶尔发现 某个接口可以获取到列表信息, 可以通过这个计算还剩多长时间能学完这个系列

结合大佬分享过的脚本工具 `TamperMonkey`

发现可以自动化这个过程... 真是太好了

### 脚本实现

```javascript
// ==UserScript==
// @name         bilibili
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       ljw532344863@sina.com
// @match        https://www.bilibili.com/video/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// ==/UserScript==

window.addEventListener('load', function(){
    (function() {
        'use strict';

        fetch("https://api.bilibili.com/x/player/pagelist?bvid=BV1bs41197KN&jsonp=jsonp")
            .then(response => response.json())
            .then(function(info){
            let data = info.data;
            let urlSearchParams = new URLSearchParams(window.location.search);
            let params = Object.fromEntries(urlSearchParams.entries());
            let currentPage = params.p;
            let isCurrentPage = function(item){return (item.page==currentPage);};

            let wanted = data.filter(isCurrentPage);
            let pageIndex = data.findIndex(isCurrentPage);

            let restPages = data.slice(pageIndex);
            // duration 的单位是秒
            let restTime = restPages.map(item => item.duration).reduce((a, b) => a + b) / 60;
            alert(`当前正在观看第 ${currentPage} 节: "${wanted[0].part}"\n剩余时间: ${parseInt(restTime)} 分钟`);
        })
            .catch(err => {
            console.log('caught it!',err);
        });

    })();
})

```

### 脚本调试方法

谷歌浏览器 -> F12 -> "Source" Tab -> "Snippets" -> "Net Snippets" -> write your script and enjoy debuging...


### Have Fun automating !!!



