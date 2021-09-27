---
title: shell-cute-tricks
date: 2021-09-27 22:56:20
tags:
---

[shebang line defination offered a cute-trick...](https://tldp.org/LDP/abs/html/abs-guide.html#FTN.AEN242)

```bash
#!/bin/rm
# Self-deleting script.

# Nothing much seems to happen when you run this... except that the file disappears.

WHATEVER=85

echo "This line will never print (betcha!)."

exit $WHATEVER  # Doesn't matter. The script will not exit here.
                # Try an echo $? after script termination.
                # You'll get a 0, not a 85.

```
