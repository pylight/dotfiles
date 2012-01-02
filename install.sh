#!/bin/bash

curDir=$(/bin/pwd)

createSym()
{
   tool=$1
   file=$2

   echo "=> Creating symlink for $tool at ~/.$file"
   ln -s $curDir/$file $HOME.$file
   
   if [ $? -eq 0 ]; then
      echo $HOME.$file >> .createdLinks   # remember linked files
   fi
}

deleteSyms()
{
   lines=0
   actions=0

   cat .createdLinks | while read LINE
   do
      echo "=> Removing $LINE"
      rm $LINE
      if [ $? -eq 0 ]; then   # rm successfull?
         let actions++
      fi
      let line++
   done

   # rm infofile if all 
   # symlinks are removed
   if [ "$lines" -eq "$actions" ]
   then
      rm .createdLinks
      echo ""
      echo "Done. To remove the whole folder, run:"
      echo "cd ; rm -R $curDir"
      echo ""
   else
      echo ""
      echo "Error while trying to delete symlinks!"
      echo "Please check your home directory and the .createdLinks-File manually."
      echo ""
   fi
}

echo "== dotfiles install script =="

if [ "$1" == "-doinstall" ]
then
   # create symlinks
   createSym tmux tmux.conf
   createSym conky conkyrc
   createSym urxvt Xdefaults

elif [ "$1" == "-uninstall" ]
then
   echo "Removing symlinks..."
   deleteSyms
else
   echo "Please read the README.md before you run this!"
   echo "Run ./install.sh -doinstall to create symlinks"
fi


