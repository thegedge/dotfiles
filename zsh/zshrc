#----------------------------------------------------------------------
# Setting TRACING=1 will enable some tracing statements which help you
# profile slow parts of your zshrc.
#----------------------------------------------------------------------
TRACING=0
if [ $TRACING -ne 0 ]; then
    zmodload zsh/datetime
    setopt promptsubst
    # Set the trace prompt to include seconds, nanoseconds, script name and
    # line number This is GNU date syntax; by default Macs ship with the BSD
    # date program, which isn't compatible
    PS4='+$EPOCHREALTIME %N:%i> '
    # Save file stderr to file descriptor 3 and redirect stderr (including
    # trace output) to a file with the script's PID as an extension.
    exec 3>&2 2>/tmp/startlog.$$
    # Set options to turn on tracing/expansion of commands contained in the
    # prompt.
    setopt xtrace prompt_subst
fi

#----------------------------------------------------------------------
# Oh-my-zsh config
#----------------------------------------------------------------------
ZSH_THEME="bira"

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
    node
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
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

#----------------------------------------------------------------------
# Include any local configuration
#----------------------------------------------------------------------
[[ -e "${HOME}/.zshrc.local" ]] && . "${HOME}/.zshrc.local"

#----------------------------------------------------------------------
# Runs all scripts in profile.d
#----------------------------------------------------------------------
for file in $(dirname "$(readlink $HOME/.zshrc)")/profile.d/*(on); do
  [ -f "$file" ] && source $file
done

#----------------------------------------------------------------------
# Disable tracing
#----------------------------------------------------------------------
if [ $TRACING -ne 0 ]; then
    # Turn off tracing.
    unsetopt xtrace
    # Restore stderr to the value saved in FD 3.
    exec 2>&3 3>&-
fi
