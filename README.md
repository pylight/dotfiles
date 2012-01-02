dotfiles 
========
This repository contains configfiles for my Archlinux systems. Feel free to use or change them to suit your needs.

Installation
-------------

The install.sh Script will create symlinks in your Homedirectory for the following tools:
* tmux (~/.tmux.conf)
* conky (~/.conkyrc)
Make sure these files aren't availiable yet, otherwise they will be skipped.

```bash
git clone git://github.com/pylight/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh -doinstall
```

