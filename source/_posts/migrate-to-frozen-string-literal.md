---
title: migrate_to_frozen_string_literal
date: 2022-03-01 23:45:04
tags:
  - best practice
  - ruby
---

[20220613 update] better use robocop auto-correct to handle this issue.
[20220728 update] `be rubocop -A **/*.rb --only Style/FrozenStringLiteralComment`

I've read a blog post written by [Mike Perham](https://github.com/mperham) introducing the **Magic Comment**, and I tried it out in my project.

The `# frozen_string_literal: true`

## STEP-1: add this "magic comment"

```ruby
# Find all ruby files.
# Iterate through them.
# Add two lines if the file doesn't have those magic comment.

basedir   = Rails.root.to_s
filenames = Dir["#{basedir}/**/*.rb"]
target    = "# frozen_string_literal: true"

filenames.each do |filename|
  lines = File.foreach(filename).first(2)

  if lines != ["#{target}\n", "\n"]
    `gsed -i "1i#{target}" "#{filename}"` # Use gsed on macos.
    `gsed -i "1G"          "#{filename}"` # Use sed  on linux.
  end
end
```

## STEP-2: do automated/manual tests

This is important, since your project code may have a situation for manipulating **Mutable String**.

## STEP-3: deploy and pay extra attention to production state

Be ready to rollback your deployment. You know, shit happens.

## Exception occurred: FrozenError

Yes, it happened...

```json
{
  "class": "ScanAlertingAndPendingWorker",
  "args": [],
  "retry": 1,
  "queue": "default",
  "jid": "0a48de6e85b383432760b013",
  "created_at": 1646124005.491867,
  "enqueued_at": 1646124034.8366895,
  "error_message": "can't modify frozen String",
  "error_class": "FrozenError",
  "failed_at": 1646124035.9765105,
  "retry_count": 0,
}
```

### Occurrence No.1

```ruby
# frozen_string_literal: true

content = ""
content << 'world'
content << 'hello'
```

solution

```ruby
# frozen_string_literal: true

content = String.new
content << 'world'
content << 'hello'
```

### Occurrence No.2

```ruby
# frozen_string_literal: true

body = 'Roses are red Mud is fun'
body.force_encoding('utf-8')
```

solution

```ruby
# frozen_string_literal: true

body = 'Roses are red Mud is fun'
body.dup.force_encoding('utf-8')
# or
String.new(body).force_encoding('utf-8')
```

## At Last

But to my disappointment, I didn't see significant memory reduction.

It might be related to the size of the system.(Is it?)


