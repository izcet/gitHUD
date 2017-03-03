githud
======
A Heads-Up Display for information about the current Git repository.

Notes
-----
Intended for zsh and created for use at 42USA.
Uses `precmd()` to run itself before ever prompt is printed. Might conflict with `Oh-My-Zsh`.

Installation
------------
```
source install.sh
```

Issues
------
1. If you use githud with a terminal less than 80 characters wide, gitbar will not format correctly. This will be fixed eventually.
