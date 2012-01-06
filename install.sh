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
   echo "cd ; rm -Rf $curDir"
   echo ""
}

echo ""
echo "============================="
echo "== dotfiles install script =="
echo "============================="
echo ""

if [ "$1" == "-doinstall" ] || [ "$1" == "--doinstall" ]
then
   # create symlinks
   createSym tmux tmux.conf
   createSym conky conkyrc
   createSym urxvt Xdefaults
   createSym abcde abcde.conf
   createSym dircolors dircolors

   # vim (optional)
   echo ""
   read -p "Also checkout vim config (submodule: https://github.com/pylight/vimrc)? [y/N] " vimprompt
   if [[ $vimprompt =~ [yY](es)* ]]
   then
      git submodule update --init vim  # checkout vim config
      echo ""
      createSym vim vim
      cd vim
      
      # get vim plugins
      echo ""
      echo "Getting vim plugins (submodules in ~/.dotfiles/vim/bundle/)..."   
      echo ""
      git submodule update --init      # checkout vim plugins
     
      # add vimrc symlink
      echo ""
      echo "=> Creating symlink for vimrc at ~/.vimrc"
      ./install-vimrc.sh
      cd $curDir
      echo $HOME/.vimrc >> .createdLinks
      
   fi

   # urxvt extensions
   echo ""
   read -p "Copy urxvt extensions to /usr/lib/urxvt/perl/ (sudo needed)? [y/N] " urxvtprompt
   if [[ $urxvtprompt =~ [yY](es)* ]]
   then
      if [ ! -d "/usr/lib/urxvt/perl/" ]
      then
         sudo mkdir -p /usr/lib/urxvt/perl/
      fi
      sudo cp urxvt-plugins/* /usr/lib/urxvt/perl/ 
   fi
   
   echo ""

   # zshrc & oh-my-zsh (optional)
   echo ""
   read -p "Use custom .zshrc (and checkout oh-my-zsh)? [y/N] " zshprompt
   if [[ $zshprompt =~ [yY](es)* ]]
   then
      createSym zsh zshrc
      git submodule update --init oh-my-zsh
      createSym oh-my-zsh oh-my-zsh
      echo ""
      echo "Done. If you want to make zsh your default shell, run:"
      echo "chsh -s /bin/zsh"
   fi
   echo ""


elif [ "$1" == "-uninstall" ] || [ "$1" == "--uninstall" ]
then
   echo "ATTENTION: This will remove the following files:"
   echo "------------------------------------------------"
   cat .createdLinks
   echo "------------------------------------------------" 

   read -p "Are you sure [y/N] " rmprompt
   if [[ $rmprompt =~ [yY](es)* ]]
   then   
      echo ""
      echo "Removing symlinks..."
      deleteSyms

      # delete submodule folders
      rm -Rf $curDir/vim
      rm -Rf $curDir/oh-my-zsh
   fi
else
   echo "Please read the README.md before you run this!"
   echo "Run ./install.sh -doinstall to create symlinks"
fi


