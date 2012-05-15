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
# Command aliases
#----------------------------------------------------------------------

# Make commands colorful
alias ls='ls -G -h'                     # ls always has color
alias less='less -R'                    # less always has color
alias grep='grep --color=always'        # grep always has color

alias df='df -h'                        # Human readable df by default
alias fastssh='ssh -C -c blowfish'      # ssh that uses compression
alias fastscp='scp -C -c blowfish'      # scp that uses compression
alias top='top -o cpu -s 1'             # top defaults to ordering by CPU usage and 1 second delay

alias java14='/System/Library/Frameworks/JavaVM.framework/Versions/1.4/Commands/java'
alias java15='/System/Library/Frameworks/JavaVM.framework/Versions/1.5/Commands/java'
alias java16='/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Commands/java'

alias unsafe_git='env GIT_SSL_NO_VERIFY=true git'

#----------------------------------------------------------------------
# Some custom functions
#----------------------------------------------------------------------

# When building an Android SDK project
build_android_project() {
	android update project -p . -s -t 1
	if [ -e build_native.sh ]
	then
		./build_native.sh
	else
		ndk-build
	fi
	ant debug
	if [ -e bin/$1-debug.apk ] ; then adb install -r bin/$1-debug.apk; fi
}

# List the contents of a module
pylist() {
	python -c "import $1; print str.join('\n', dir($1))"
}

# Apply a command (first argument) to each file given (every other argument)
foreach() {
	cmd=$1
	shift
	for i in $@
	do
		eval `echo ${cmd} | sed s/file/$i/g`
	done
}

# Total line count in files
lc() {
	echo "Total # Lines: " `cat $@ 2>/dev/null | wc -l`
}

# Total line count for source files of a given type
lc4type() { 
	TYPES=`echo "$@" | sed 's/ /" -or -name "*./g'`
	TYPES="-name \"*.${TYPES}\""
	echo "Total # Lines: " `eval "find . ${TYPES}" | sed -e"/\.svn/d" -e"/build/d" | sed "s/\(.*\)/\"\1\"/" | xargs cat 2>/dev/null | sed '/^[ \t]*$/d' | wc -l`
}

# Total line count for files on STDIN 
lc4files() {
	echo "Total # Lines: " `cat /dev/stdin | sed -e"/\.svn/d" -e"/build/d" | sed "s/\(.*\)/\"\1\"/" | xargs cat 2>/dev/null | wc -l`
}

#----------------------------------------------------------------------
# Default editor
#----------------------------------------------------------------------
export EDITOR="vim"

#----------------------------------------------------------------------
# Load ~/.MacOSX/environment.plist into shell environment
#----------------------------------------------------------------------
eval `${HOME}/.dotfiles/scripts/parse_environment_plist.rb`

#----------------------------------------------------------------------
# Other stuff
#----------------------------------------------------------------------
export SSH_ASKPASS="/usr/libexec/ssh-askpass"
export DISPLAY=":0"

if [ -d "${HOME}/scripts" ]; then
	export PATH="${HOME}/scripts:${PATH}"
fi

#----------------------------------------------------------------------
# For homebrew
#----------------------------------------------------------------------
export PATH="${HOME}/usr/local/bin:${HOME}/usr/local/sbin:${HOME}/usr/local/share/python:${PATH}"
export MANPATH="${HOME}/usr/local/man:${MANPATH}"

#----------------------------------------------------------------------
# For virtualenv
#----------------------------------------------------------------------
export WORKON_HOME="${HOME}/.virtualenvs"
export VIRTUALENVWRAPPER_PYTHON="${HOME}/usr/local/bin/python2.7"
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

source /usr/local/bin/virtualenvwrapper.sh

#----------------------------------------------------------------------
# For rvm
#----------------------------------------------------------------------
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && . "${HOME}/.rvm/scripts/rvm" # Load RVM function

#----------------------------------------------------------------------
# Bash completion
#----------------------------------------------------------------------
. ${HOME}/.dotfiles/scripts/bash_completion/bash_completion
. ${HOME}/.dotfiles/scripts/django_bash_completion


