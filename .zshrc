# If you come from bash you might have to change your $PATH. 
#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.

# for Mac
#export ZSH="/Users/reginalin/.oh-my-zsh"


# for Linux
export ZSH="/home/lregina/.oh-my-zsh"
export CLICOLOR=1

# Set name of the theme to load --- if set to "random", it will load a random theme each time oh-my-zsh is loaded, in which case, to know which specific one was loaded, run: echo $RANDOM_THEME See 
# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# Set list of themes to pick from when loading at random Setting this variable when ZSH_THEME=random will cause zsh to load a theme from this variable instead of looking in ~/.oh-my-zsh/themes/ If set to an empty array, this 
# variable will have no effect. ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#ZSH_THEME="agnoster"
ZSH_THEME="spaceship"

DISABLE_LS_COLORS="true"

DISABLE_AUTO_TITLE="true" 

ENABLE_CORRECTION="true"

# Plugins {{{

# Which plugins would you like to load? Standard plugins can be found in ~/.oh-my-zsh/plugins/* Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/ Example format: plugins=(rails git textmate ruby lighthouse) Add wisely, 
# as too many plugins slow down shell startup.
# export ZPLUG_HOME="$HOME/.zplug"

source $ZSH/oh-my-zsh.sh
#}}}
# User configuration {{{

#user @ hostname export PROMPT='%$USER@%m> $(git_prompt_info)' export PROMPT='%(!.%{%F{yellow}%}.)$USER@%{$fg[white]%}%M ${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim' else export EDITOR='mvim' fi

# Compilation flags export ARCHFLAGS="-arch x86_64"
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
alias createv='python3 -m venv venv' # create virtualenv
alias venv='source venv/bin/activate' # activate virtualenv

# poetry spawn new shell
alias poets='poetry shell'
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
# Spaceship prompt {{{
SPACESHIP_PROMPT_ORDER=(
  #time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  #host          # Hostname section
  git           # Git section (git_branch + git_status)
  #hg            # Mercurial section (hg_branch  + hg_status)
  #package       # Package version
  node          # Node.js section
  #ruby          # Ruby section
  #elixir        # Elixir section
  #xcode         # Xcode section
  #swift         # Swift section
  golang        # Go section
  #php           # PHP section
  rust          # Rust section
  #haskell       # Haskell Stack section
  #julia         # Julia section
  #docker        # Docker section
  #aws           # Amazon Web Services section
  venv          # virtualenv section
  #conda         # conda virtualenv section
  pyenv         # Pyenv section
  #dotnet        # .NET section
  #ember         # Ember.js section
  #kubecontext   # Kubectl context section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  #vi_mode       # Vi-mode indicator
  #jobs          # Background jobs indicator
  #exit_code     # Exit code section
  char          # Prompt character
)
 
SPACESHIP_USER_SHOW=always
SPACESHIP_USER_SUFFIX=' 🍁  '

SPACESHIP_GIT_BRANCH_PREFIX='🌱 ['
SPACESHIP_GIT_BRANCH_SUFFIX=']'
#SPACESHIP_GIT_STATUS_MODIFIED=''

# }}}
# Sourcing {{{

include() {
  [[ -f "$1" ]] && source "$1"
}
include ~/.bash/sensitive
# }}}
