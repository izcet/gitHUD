gitbar
======
A small utility to show information about the current Git repository.

Notes
-----
Uses `precmd()` to run itself before ever prompt is printed. Might conflict with `Oh-My-Zsh`.

Installation
------------
```
source install.sh
```

Issues
------
1. If you use gitbar with a terminal less than 80 characters wide, gitbar will not format correctly. This will be fixed eventually.
