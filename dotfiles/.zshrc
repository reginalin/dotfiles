# Environ {{{

export CLICOLOR=1
export VIRTUAL_ENV_DISABLE_PROMPT=0
ENABLE_CORRECTION="true"

# Configure man pages

export MANWIDTH=79

# }}}
# Dark/light mode {{{
 
function dark() {
  alacritty-colorscheme \
    -c $HOME/.alacritty.yml \
    apply ayu_dark.yaml

  if [ ! -z "$TMUX" ]; then
    tmux source-file ~/.tmux.conf
  fi
}

function light() {
  alacritty-colorscheme \
    -c $HOME/.alacritty.yml \
    apply papercolor_light.yaml

  if [ ! -z "$TMUX" ]; then
    tmux source-file ~/.tmux-light
  fi
}

# }}}
# Zshell: shell prompt config {{{

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
# Zshell: plugins {{{
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
# Zshell: startup config {{{

alias weather='curl wttr.in'
alias cow='cowsay hello'
alias motivate='motivate --no-colors | cowthink -f unipony-smaller' 
alias fortune='fortune | lolcat'

greeting="good morning"

time=$(date +%H)
if [ $((time)) -lt 12 ]; then
  greeting="good morning"
elif [ $((time)) -lt 17 ]; then
  greeting="good afternoon"
else
  greeting="good evening"
fi

figlet $greeting

MOTIVATION=$(motivate)
CLEAN_MOTIVATION=${MOTIVATION[@]//\[1;m/}

motivate

# }}}
# Functions {{{

function include() {
  [[ -f "$1" ]] && source "$1"
}

# }}}
# Aliases {{{
# To see list of active aliases, run `alias`.
alias nvim='~/tools/nvim.appimage'
alias f='nvim'
alias vi='nvim'
alias vim='nvim'
alias c='clear'
alias sz='source ~/.zshrc' # reload zshrc
alias editv='vim ~/.config/nvim/init.vim'
alias editt='vim ~/.tmux.conf'
alias editz='vim ~/.zshrc'

# Python
alias ve='python3 -m venv venv' # create virtualenv
alias va='source venv/bin/activate' # activate virtualenv

# Git
alias gg='git log --oneline --abbrev-commit --all --graph --decorate'

# Kepler
alias rocket='cd ~/KIP-Rocket'
alias kepler='cd ~/Kepler'

# Join zoom and get correct audio input
function active_input_port() {
  pactl list sources | grep 'Active Port:' | cut -d ':' -f 2 | xargs
}

function check_input_port() {
  local SOURCE="alsa_input.pci-0000_00_1f.3.analog-stereo"
  local DESIRED_INPUT="analog-input-headset-mic"
  local current=$(active_input_port)
  if [ "$current" != "$DESIRED_INPUT" ]; then
    echo "Changing active port from '$current' to '$DESIRED_INPUT'"
    pactl set-source-port $SOURCE $DESIRED_INPUT
    if [ $? -ne 0 ]; then
      echo "Failed to configure the source port: $DESIRED_INPUT. Maybe not connected?"
      return 1
    fi
  fi
}
function zoomy() {
  check_input_port
  xdg-open "zoommtg://zoom.us/join?action=join&confno=$1" > /dev/null 2>&1
}

fpath+=${ZDOTDIR:-~}/.zsh_functions

# }}}
# Sourcing {{{

include ~/.bash/sensitive
include ~/.fzf.zsh

# }}}
# Imports: asdf (needs to run after zsh setup) {{{

include $HOME/.asdf/asdf.sh
include $HOME/.asdf/completions/asdf.bash

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
