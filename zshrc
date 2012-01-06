# pylights .zshrc (https://github.com/pylight/dotfiles)
#
# @dep: - oh-my-zsh (get it from https://github.com/robbyrussell/oh-my-zsh)
#       - egrep for dirsize function 
#       - w3m for dictionary functions
#

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(extract git)

source $ZSH/oh-my-zsh.sh
source /etc/profile        # needed for autojump

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl:/opt/java/bin

# some handy aliases
alias alias ls='ls --color=always -h --group-directories-first'
alias la="ls -la"
alias tree="tree -c"
alias jd="cd /media/truecrypt1/Programme/JDownloader && java -jar JDownloader.jar -Xmx512m &>/dev/null &"
alias psall="/bin/ps aux"
alias cp="cp -p"
alias vi="vim"
alias svim="sudo vim"
alias du='du -h' df='df -h'
alias cpu='ps aux | sort -k 3,3 | tail | tac'  
alias mem='ps aux | sort -k 4,4 | tail | tac'  
alias pacman='sudo pacman-color'
alias zZ="sudo pm-suspend"
alias Zz="zZ"
alias re="sudo reboot"
alias stfu="sudo shutdown -h now"
alias stfu="sudo shutdown -h now"
alias fuckoff="killall -9"
alias die="kill -9"
alias addgsn="ssh-add ~/.ssh/ident/me-server@ganz-sicher.net"
alias addgit="ssh-add ~/.ssh/ident/git@github.com"
alias gcam="git commit -am" # for other git aliases, see git plugin
alias gcma="gcam"
alias webserver="sudo /etc/rc.d/httpd start"
# edit configs
alias vimc="vim $HOME/.vimrc"
alias zshc="vim $HOME/.zshrc"

# set vim as default editor
export EDITOR="/usr/bin/vim"

# blogging helpers
JEKYLLDIR="/srv/http/jekyll"
alias blogpost="python $JEKYLLDIR/_scripts/newpost.py"
startjekyll()
{
   if [ `/usr/bin/whoami` = "root" ]; then
      echo "Please use jekyll with a normal user account!"
   elif [ `/bin/pwd` != "$JEKYLLDIR" ]; then
      echo "Please only use jekyll in $JEKYLLDIR."
   else
      jekyll
   fi
}
alias jekyll="startjekyll"

# make dir and go to dir
function mkgo () {
  mkdir -p "$1"
    cd "$1"
 }
 
# copy and go to dir
cpgo (){
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}
 
# move and go to dir
mvgo (){
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}

#dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
   du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
   egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
   egrep '^ *[0-9.]*M' /tmp/list
   egrep '^ *[0-9.]*G' /tmp/list
   rm /tmp/list
}


# dictionaries
function dict() {
 w3m -dump "http://pocket.dict.cc?s=\"$*\"" | sed -r -e '/^([ ]{5,}.*)$/d' -e '1,2d' -e '/^$/d' -e '/^\[/d'
}
function leo() {
 w3m -dump "http://pda.leo.org/?search=\"$*\"" | sed -n -e :a -e '1,9!{P;N;D;};N;ba' | sed -e '1,14d'
}
function leofr(){
 w3m -dump "http://pda.leo.org/?lp=frde&search=\"$*\"" | sed -n -e :a -e '1,9!{P;N;D;};N;ba' | sed -e '1,14d'
}

# enable parent dir support (cd)
zstyle ':compiletion:*' special-dirs true

# use custom dircolors
eval `dircolors $HOME/.dircolors`
