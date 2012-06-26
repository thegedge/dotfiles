#!/bin/bash
#----------------------------------------------------------------------
# Colors!
#----------------------------------------------------------------------
export PS1="\[\033[01;32m\]\u \[\033[01;33m\]\w \$ \[\033[00m\]"

export LSCOLORS="DxfxcxdxCxegedabagacad"

export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;32m'       # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[01;32m'       # begin underline


#----------------------------------------------------------------------
# Bash completion
#----------------------------------------------------------------------
. ${HOME}/.dotfiles/scripts/bash_completion/bash_completion
. ${HOME}/.dotfiles/scripts/django_bash_completion
