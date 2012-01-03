#!/bin/bash

curDir=$(/bin/pwd)

createSym()
{
   tool=$1
   file=$2

   echo "=> Creating symlink for $tool at ~/.$file"
   ln -s $curDir/$file $HOME/.$file
   
   if [ $? -eq 0 ]; then
      echo $HOME/.$file >> .createdLinks   # remember linked files
   fi
}

deleteSyms()
{
   cat .createdLinks | while read LINE
   do
      echo "=> Removing $LINE"
      rm $LINE
   done

   rm .createdLinks
   echo ""
   echo "Done. To remove the whole folder, run:"
   echo "cd ; rm -R $curDir"
   echo ""
}


echo "== dotfiles install script =="

if [ "$1" == "-doinstall" ] || [ "$1" == "--doinstall" ]
then
   # create symlinks
   createSym tmux tmux.conf
   createSym conky conkyrc
   createSym urxvt Xdefaults
   
   # vim (optional)
   read -p "Also setup vim config (https://github.com/pylight/vimrc)? [y/N] " prompt
   if [[ $prompt =~ [yY](es)* ]]
   then
      git submodule update --init
      createSym vim vim
      cd $HOME/.vim
      git submodule update --init
      ./install-vimrc.sh
      cd $curDir
      echo $HOME/.vimrc >> .createdLinks
   fi

elif [ "$1" == "-uninstall" ] || [ "$1" == "--uninstall" ]
then
   echo "Removing symlinks..."
   deleteSyms
   rm -Rf $curDir/vim
else
   echo "Please read the README.md before you run this!"
   echo "Run ./install.sh -doinstall to create symlinks"
fi


