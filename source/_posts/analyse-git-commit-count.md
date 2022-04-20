---
title: analyse-git-commit-count
date: 2022-04-21 00:15:41
tags:
  - git
  - ruby
  - terminal
---


## INTRO

最近捣鼓出一个小工具, 用来分析某个git仓库里所有人的commit, 看看某个人在这个仓库里做过多少提交

虽然统计结果不可能完全准确, 但是足够满足好奇心了

> 核心: `git shortlog --summary --numbered --email --all`

## SETUP

+ prerequisite: [` gem install youplot`](https://github.com/red-data-tools/YouPlot)
+ `vim $ABS_PATH/analyse-git-info.rb`

```ruby
require 'pry'
require 'csv'
require 'tempfile'

def write_output_as_csv(output, output_csv_file_path)
  headers = output.first.keys

  CSV.open(output_csv_file_path, "w") do |csv|
    csv << headers

    output.each do |hash|
      csv << hash.values
    end
  end
end

def datasource
  `git shortlog --summary --numbered --email --all`.split("\n")
end

def output
  records = []

  datasource.each do |line|
    result = line.match(/(\d{1,})(.*)(<.*>)/)

    record = {}
    record[:email] = result[3].strip
    record[:count] = result[1].strip

    records << record
  end

  deduplicate(records)
end

def deduplicate(arr)
  arr.group_by {|r| r[:email]}.each_with_object([]) do |(email, records), mem|
    mem << {email: email, count: records.map {|record| record[:count].to_i}.sum}
  end.sort_by {|record| record[:count]}.reverse
end

def run
  Tempfile.create(["gitinfo.", ".csv"]) do |file|
    filepath = file.path

    write_output_as_csv(output, filepath)

    File.readlines(filepath).drop(1).each {|line| puts line}
  end
end

run
```

## HAVE FUN

```bash
# cd to any git repo
ruby $ABS_PATH/analyse-git-info.rb | uplot bar -o -d, -t "Git commit count of user"
````

## TODO

+ 这个小工具做成gem
+ 用rspec写测试(练习...)
+ 怎么能使得它接收 stdin 也能正常工作呢?


