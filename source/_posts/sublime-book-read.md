---
title: sublime-book-read
date: 2021-09-24 14:16:54
tags:
  - sublime
---

> sublime-text-power-userpdf.pdf

### command palette

cmd + p

cmd + p -> : (go to line xxx)

cmd + p -> @ (or cmd + r) (go to Code & Text Blocks)

cmd + p -> # (fuzzy search 在某个文件里做模糊搜索)

#### Chaining Commands

多个命令可以连起来使用

e.g.

cmd + p -> README.md:80
cmd + p -> README.md#keyword
cmd + p -> README.md@title_xx

### Excluding Files & Folders From Search

Preferences —>Settings - User and defining the binary_file_patterns property:


ignore files
```json
"binary_file_patterns": [".DS_Store", "H.gitignore", "*.psd"]
```

ignore folders

```json
"binary_file_patterns": ["node_modules/", "vendor/", "tmp/"]
```

### sidebar

cmd + k, cmd + b

### distraction free mode

view -> "enter distraction free mode"

ctrl + cmd + shift + f

### status bar

view -> hide/show status bar

### minimap

view -> hide/show minimap

### multiple panel

view -> layout -> xxx


### Moving Between Tab

cmd + option + arrows(-> or <-)


### Multiple Carets/cursor 多光标

ctrl + shift + up/down arrows

cmd + click

### Quick Find Next / Quick Skip Next

cmd + d, and cmd + k + d to skip


### Creating Snippets

Tools —► New snippet

### tool -> developer

new plugin
new snippet
new syntax

### Search and replace

cmd + f
cmd + shift + f

cmd + g
cmd + shift + g

#### Search Options

regex search
case sensitive
whole word
show context

### move line up/down

ctrl + cmd + up/down arrows

### line duplicating

cmd + shift + d

### delete line

cmd + backspace (backword delete)
ctrl + k (forward delete)

ctrl + shift + k (delete the whole line)

ctrl + backspace (backword delete word)
ctrl + fn + backspace (forward delete word)


### insert line

cmd + shift + enter (insert before)
cmd + enter (insert after)


### jump by word

option + left/right arrows


到105页了

### Projects(page107)

> Projects in Sublime Text are a nice way to manage different websites or applications that you may be working on. The main benefit to using projects in Sublime Text are the ability to have specific editor settings that apply only to that specific projects. This is especially helpful when working with teams who may not have their editor setup properly for contributing.

There are two files that make up a Sublime Text project: the `.sublime-project` file and the `.sublime-workspace` file.

The first being a file to hold your projects settings and the second being a place where the editor can dump user specific data.

If you were to open the .sublime-workspace file, you would see all kinds of things from previously opened files to editor settings. You will never need to edit this file, so it's best just to ignore it.

When working with version control, the .sublime-project file should be checked in and shared while the .sublime-workspace file should not. I find it helpful to get myself into the habit of adding .sublime-workspace to all my .gitignore files.


### recording a macro

tools -> record macro

tools -> save macro -> "untitled.sublime-macro"

### **sublime building system**

仔细研究一下

> Build tasks are housed in a .sublime-build file which is aJSON file that holds a number of options for running

> Your own build files can live anywhere in your user folder. I recommend creating a build folder inside of the your user folder that will hold all of your build tasks.

### bookmarks

### Mastering Emmet

Emmet is a package for Sublime Text that helps with writing of CSS and HTML. To say that it speeds you up is an understatement, you would be silly to code HTML or CSS without this package installed.


### workflow and code quality

page 162


### vim mode

https://github.com/guillermooo/Vintageous


### must have add-on packages

+ Emmet

+ AutoFilename

+ Html-Css-Json Prettifyer

+ Sidebar Enhancements

+ Open With...

+ Alignment

+ Bracket Highlighter

+ MarkdownTOC

+ BufferScroll (Maintaining State on a file)

+ TODO

2021-09-24 14:16:09 读完了.
