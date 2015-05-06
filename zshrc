#----------------------------------------------------------------------
# Path to oh-my-zsh configuration.
#----------------------------------------------------------------------
ZSH=$HOME/.oh-my-zsh

#----------------------------------------------------------------------
# Theming
#----------------------------------------------------------------------
ZSH_THEME="bira"

#----------------------------------------------------------------------
# Plugins used by oh-my-zsh
#----------------------------------------------------------------------
plugins=(
    aws
    brew
    bundler
    chruby
    cmake
    django
    docker
    gem
    go
    knife
    mvn
    node
    npm
    osx
    pip
    svn
    tmux
    vagrant
)

#----------------------------------------------------------------------
# Command history
#----------------------------------------------------------------------
HISTFILE=~/.history
SAVEHIST=10000
HISTSIZE=10000
setopt APPEND_HISTORY # don't overwrite history; append instead
setopt INC_APPEND_HISTORY # append after each command
#setopt SHARE_HISTORY # share history between shells
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

#----------------------------------------------------------------------
# zsh performance tweaks
#----------------------------------------------------------------------
# .. use a cache file
zstyle ':completion:*' use-cache on

# .. and then specify the cache file to use (not added to repo: separate file for each machine)
zstyle ':completion:*' cache-path ~/.zshcache

#----------------------------------------------------------------------
# Other options
#----------------------------------------------------------------------
setopt EXTENDED_GLOB

#----------------------------------------------------------------------
# Bring oh-my-zsh into the picture
#----------------------------------------------------------------------
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

#----------------------------------------------------------------------
# Include any local configuration
#----------------------------------------------------------------------
[[ -e "${HOME}/.zshrc.local" ]] && . "${HOME}/.zshrc.local"
