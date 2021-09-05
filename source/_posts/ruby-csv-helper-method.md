---
title: ruby-csv-helper-method
date: 2021-09-05 22:57:40
tags:
  - csv
  - ruby
---

### background

+ 一般情况下, 对程序来说处理文本是最友好的
+ 对程序来说, csv的数据比excel更友好

### read

```ruby
require 'csv'

def get_array_of_hashes(input_csv_file_path)
  result = []
  CSV.foreach(input_csv_file_path, headers: true, converters: :all) do |row|
    result << row.to_h.transform_keys(&:to_sym)
  end

  result
end
```

### write

```ruby
require 'csv'

def write_output_as_csv(output, output_csv_file_path)
  headers = output.first.keys

  CSV.open(output_csv_file_path, "w") do |csv|
    csv << headers

    output.each do |hash|
      csv << hash.values
    end
  end
end
```

### example workflow

```ruby
def get_output(datasource)
  # xxx
end

def run
  input_file_path = "xxx.csv"
  datasource = get_array_of_hashes(input_file_path)

  output_csv_file_path = "yyy.csv"
  output = get_output(datasource)

  write_output_as_csv(output, output_csv_file_path)
end

run
```

