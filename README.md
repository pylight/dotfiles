dotfiles 
========
This repository contains configfiles for my Archlinux systems. Feel free to use or change them to suit your needs.

Installation
-------------
The install.sh script will create symlinks in your Homedirectory for the following tools:

* tmux (~/.tmux.conf)
* conky (~/.conkyrc)
* urxvt (~/.Xdefaults)

Make sure these files aren't availiable yet, otherwise they will be skipped with a warning.

```bash
git clone git://github.com/pylight/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh -doinstall
```

