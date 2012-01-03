dotfiles 
========
This repository contains configfiles for my Archlinux systems. Feel free to use or change them to suit to your needs.

Screenshots:
* [urxvt and vim](http://i.imgur.com/YbTyK.jpg)
* [conky](http://i.imgur.com/9ECzo.jpg)

Installation
-------------
The install.sh script will create symlinks in your Homedirectory for the following tools:

* tmux (~/.tmux.conf)
* conky (~/.conkyrc)
* urxvt (~/.Xdefaults)
* optional: vim (~/.vimrc) - added as submodule from my [vim-repo](https://github.com/pylight/vimrc)

Make sure these files aren't availiable yet, otherwise they will be skipped with a warning. If you don't need a config, just comment out the respective createSym-statement in install.sh. You might also take a short look at the config files to find out more about dependencies and shortcuts. 

```bash
git clone git://github.com/pylight/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh -doinstall
```

Uninstall Process
------------------

The install.sh script can be used to remove the created symlinks again:

```bash
cd ~/.dotfiles
./install.sh -uninstall
```

The script tells you how to uninstall the repository folder afterwards.
