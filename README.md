### A minor revision of the gitHud script output to declutter the terminal.
- Prints to the window title rather than after every command execution.
- Running `install.sh` (unmodified) will update the main script to use this version.

###### Original:
![iwordes/gitHUD](https://raw.githubusercontent.com/izcet/gitHUD/master/old.png)
<br>

###### Update:
![izcet/gitHUD](https://raw.githubusercontent.com/izcet/gitHUD/master/new.png)
<br>

gitHUD
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
