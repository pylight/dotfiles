dotfiles 
========
This repository contains configfiles for my Archlinux systems. Feel free to use or change them to suit to your needs.

**Screenshot:**

* [urxvt and vim + conky on the right](http://i.imgur.com/HQFxL.jpg)
* [dircolors and zsh with git plugin](http://i.imgur.com/MiWsu.png)

Installation
-------------
The install.sh script will create symlinks in your Homedirectory for the following tools:

* [tmux](http://tmux.sourceforge.net/) (~/.tmux.conf)
* [conky](http://conky.sourceforge.net/) (~/.conkyrc)
* [urxvt](https://wiki.archlinux.de/title/Urxvt) (~/.Xdefaults)
* [abcde](http://andrews-corner.org/abcde.html) (~/.abcde.conf)
* dircolors with [solarized](http://ethanschoonover.com/solarized) color scheme (~/.dircolors)
* optional: [vim](http://www.vim.org/) (~/.vimrc and ~/.vim) - added as submodule from my [vim-repo](https://github.com/pylight/vimrc)
* optional: [zsh](http://www.zsh.org/) (creates ~/.zshrc and ~/.oh-my-zsh symlink to the submodules folder)

Make sure these files aren't availiable yet, otherwise they will be skipped with a warning. If you don't need a config, just comment out the respective createSym-statement in install.sh. You might also take a short look at the config files to find out more about dependencies and shortcuts. 

```bash
git clone git://github.com/pylight/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh --doinstall
```

Uninstall Process
------------------

The install.sh script can be used to remove the created symlinks again:

```bash
cd ~/.dotfiles
./install.sh --uninstall
```

The script tells you how to uninstall the repository folder afterwards.


Feedback
---------

Suggestions/improvements are always [welcome](https://github.com/pylight/dotfiles/issues)!
