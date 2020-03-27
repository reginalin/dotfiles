# If you come from bash you might have to change your $PATH. 
#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

# for Mac
#export ZSH="/Users/reginalin/.oh-my-zsh"

# for Linux
export CLICOLOR=1
export VIRTUAL_ENV_DISABLE_PROMPT=0

# Set name of the theme to load --- if set to "random", it will load a random theme each time oh-my-zsh is loaded, in which case, to know which specific one was loaded, run: echo $RANDOM_THEME See 
# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

DISABLE_LS_COLORS="true"

DISABLE_AUTO_TITLE="true" 

ENABLE_CORRECTION="true"

# Geometry config {{{
if [[ ! -v GEOMETRY_PROMPT_PLUGINS ]]; then
  GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time git)
fi

GEOMETRY_STATUS_SYMBOL="▲"             # default prompt symbol
GEOMETRY_STATUS_SYMBOL_ERROR="△"       # displayed when exit value is != 0
GEOMETRY_STATUS_COLOR_ERROR="magenta"  # prompt symbol color when exit value is != 0
GEOMETRY_STATUS_COLOR="default"        # prompt symbol color
GEOMETRY_STATUS_COLOR_ROOT="red"       # root prompt symbol color
GEOMETRY_COLOR_VIRTUALENV="green"

setopt PROMPT_SUBST
# }}}
# Plugins {{{
if [ -f ~/.zplug/init.zsh ]; then
  source ~/.zplug/init.zsh

  # BEGIN: List plugins

  # use double quotes: the plugin manager author says we must for some reason
  zplug "zsh-users/zsh-completions", as:plugin
  zplug "zsh-users/zsh-syntax-highlighting", as:plugin
  zplug "geometry-zsh/geometry", as:plugin

  #END: List plugins

  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi

  # Then, source plugins and add commands to $PATH
  zplug load
else
  echo "zplug not installed, so no plugins available"
fi
# }}}
# Aliases {{{ Set personal aliases, overriding those provided by oh-my-zsh libs, plugins, and themes. Aliases can be placed here, though oh-my-zsh users are encouraged to define aliases within the ZSH_CUSTOM folder. For a full 
# list of active aliases, run `alias`.
#
# Example aliases alias zshconfig="mate ~/.zshrc" alias ohmyzsh="mate ~/.oh-my-zsh"

# USEFUL aliases {{{
# Run neovim (on Linux)
alias nvim='~/tools/nvim.appimage'

# Remap vim to neovim
alias f='nvim'
alias vi='nvim'
alias vim='nvim'

# Get sublime color theme to work in tmux
alias tmux='tmux -2'

# Clear
alias c='clear'

# Reload zshrc
alias sz='source ~/.zshrc'

# open vim anywhere
alias editv='vim ~/.vimrc'

# open tmux anywhere
alias editt='vim ~/.tmux.conf'

# open zshrc anywhere
alias editz='vim ~/.zshrc'

# virtual environment	
 alias ve='python3 -m venv venv' # create virtualenv
 alias va='source venv/bin/activate' # activate virtualenv

# poetry spawn new shell
alias poets='poetry shell'

# Kepler
alias rocket='cd ~/KIP-Rocket'
alias kepler='cd ~/Kepler'
# }}}
# FUN aliases {{{
# Weather
alias weather='curl wttr.in'

# Cowsay 
alias cow='cowsay hello'

# Motivational thinking unicorn 
alias motivate='motivate --no-colors | cowthink -f unipony-smaller' 

# Make fortunes colorful
alias fortune='fortune | lolcat'
# }}}
# }}}
# Fun start up stuff {{{

# Figlet bold fonts
greeting="good morning"
time=$(date +%H)
if [ $((time)) -lt 12 ]; then
  greeting="good morning"
elif [ $((time)) -lt 17 ]; then
  greeting="good afternoon"
else
  greeting="good evening"
fi

# figlet $greeting | lolcat
figlet $greeting

# Motivational rainbow animal 
MOTIVATION=$(motivate)
CLEAN_MOTIVATION=${MOTIVATION[@]//\[1;m/}
#echo $CLEAN_MOTIVATION | lolcat
motivate

# }}}
# asdf {{{
. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
# }}}
# Sourcing {{{

include() {
  [[ -f "$1" ]] && source "$1"
}
include ~/.bash/sensitive
# }}}
# Git {{{
# GIT: prune/cleanup the local references to remote branch
# and delete merged local branches
function gc() {
  local refs="$(git remote prune origin --dry-run)"
  if [ -z "$refs" ]
  then
    echo "No prunable references found"
  else
    echo $refs
    while true; do
     read yn\?"Do you wish to prune these local references to remote branches?"
     case $yn in
       [Yy]* ) break;;
       [Nn]* ) return;;
       * ) echo "Please answer yes or no.";;
     esac
    done
    git remote prune origin
    echo "Pruned!"
  fi
​
  local branches="$(git branch --merged master | grep -v '^[ *]*master$')"
  if [ -z "$branches" ]
  then
    echo "No merged branches found"
  else
    echo $branches
    while true; do
     read yn\?"Do you wish to delete these merged local branches?"
     case $yn in
       [Yy]* ) break;;
       [Nn]* ) return;;
       * ) echo "Please answer yes or no.";;
     esac
    done
    echo $branches | xargs git branch -d
    echo "Deleted!"
  fi
}

# Print out the Github-recommended gitignore
export GITIGNORE_DIR=$HOME/src/lib/gitignore
function gitignore() {
  if [ ! -d "$GITIGNORE_DIR" ]; then
    mkdir -p $HOME/src/lib
    git clone https://github.com/github/gitignore $GITIGNORE_DIR
    return 1
  elif [ $# -eq 0 ]; then
    echo "Usage: gitignore <file1> <file2> <file3> <file...n>"
    return 1
  else
    # print all the files
    local count=0
    for filevalue in $@; do
      echo "#################################################################"
      echo "# $filevalue"
      echo "#################################################################"
      cat $GITIGNORE_DIR/$filevalue
      if [ $count -ne $# ]; then
        echo
      fi
      (( count++ ))
    done
  fi
}
compdef "_files -W $GITIGNORE_DIR/" gitignore
# }}}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
