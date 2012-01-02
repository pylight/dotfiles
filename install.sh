#!/bin/bash

curDir=$(/bin/pwd)

createSym()
{
   tool=$1
   file=$2

   echo "Creating symlink for $tool at ~/.$file"
   ln -s $curDir/$file $HOME.$file
}


echo "== dotfiles install script =="

if [ "$1" == "-doinstall" ]
then
   # create symlinks
   createSym tmux tmux.conf
   createSym conky conkyrc
   createSym urxvt Xdefaults
else
   echo "Please read the README.md before you run this!"
   echo "Run ./install.sh -doinstall to create symlinks"
fi


