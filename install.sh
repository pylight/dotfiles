#!/bin/bash
# this script is used to set up all relevant configuration files in my linux system

curDir=$(/bin/pwd)

createSym()
{
   tool=$1
   file=$2

   echo "=> Creating symlink for $tool at ~/$file"
   ln -s $curDir/$file $HOME/$file
   
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

installation() 
{
   # create symlinks
   echo "Creating config symlinks..."
   createSym conky .conkyrc
   createSym urxvt .Xdefaults
   createSym dircolors .dircolors
   createSym compton .config/compton.conf

   # vim (optional)
   echo ""
   read -p "Also checkout vim config (submodule: https://github.com/pylight/vimrc)? [y/N] " vimprompt
   if [[ $vimprompt =~ [yY](es)* ]]
   then
      git submodule update --init --remote vim  # checkout vim config
      echo ""
      createSym vim vim
      cd vim
      
      # get vim plugins
      echo ""
      echo "Getting vim plugins (submodules in ~/.dotfiles/vim/bundle/)..."   
      echo ""
      git submodule update --init --remote      # checkout vim plugins
     
      # add vimrc symlink
      echo ""
      echo "=> Creating symlink for vimrc at ~/.vimrc"
      ./install-vimrc.sh
      cd $curDir
      echo $HOME/.vimrc >> .createdLinks
      echo "[INFO] Done - optional: 'vim-spell-de' for german spell checking (using <F4>-Shortcut)"  

      # also make sure root will use the vim config
      echo ""
      echo "=> Creating symlink for vimrc at ~/.vimrc"
   fi

   # urxvt extensions
   echo ""
   read -p "Install urxvt-tabbedex for named tab support? (installed yaourt needed)? [y/N] " urxvtprompt
   if [[ $urxvtprompt =~ [yY](es)* ]]
   then
      yaourt -S urxvt-tabbedex
   fi

   # zshrc & oh-my-zsh (optional)
   echo ""
   read -p "Use custom .zshrc (and checkout oh-my-zsh)? [y/N] " zshprompt
   if [[ $zshprompt =~ [yY](es)* ]]
   then
      pacman -S zsh
      createSym zsh zshrc
      git submodule update --init --remote oh-my-zsh
      createSym oh-my-zsh oh-my-zsh
      sudo pacman -S zsh
      echo ""
      echo "Done. If you want to make zsh your default shell, run:"
      echo "chsh -s /bin/zsh"
   fi
   echo ""
}

uninstallation() 
{
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
}




echo ""
echo "============================="
echo "== dotfiles install script =="
echo "============================="
echo ""

if [ "$1" == "-doinstall" ] || [ "$1" == "--doinstall" ] || [ "$1" == "--do-install" ] || [ "$1" == "--install" ]
then
   installation

elif [ "$1" == "-uninstall" ] || [ "$1" == "--uninstall" ]
then
   uninstallation
else
   echo "Please read the README.md before you run this!"
   echo "Run ./install.sh -doinstall to create symlinks"
fi


