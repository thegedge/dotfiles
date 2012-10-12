#!/bin/bash
#----------------------------------------------------------------------
# Include any local configuration (post profile)
#----------------------------------------------------------------------
[[ -e "${HOME}/.profile-pre.local" ]] && . "${HOME}/.profile-pre.local"

#----------------------------------------------------------------------
# Command aliases
#----------------------------------------------------------------------

# Make commands colorful
alias ls='ls -G -h'                     # ls always has color
alias less='less -R'                    # less always has color

alias f='find . -name'                  # simplified find for basic search in current directory
alias df='df -h'                        # Human readable df by default
alias fastssh='ssh -C -c blowfish'      # ssh that uses compression
alias fastscp='scp -C -c blowfish'      # scp that uses compression
alias top='top -o cpu -s 1'             # top defaults to ordering by CPU usage and 1 second delay

alias java14='/System/Library/Frameworks/JavaVM.framework/Versions/1.4/Commands/java'
alias java15='/System/Library/Frameworks/JavaVM.framework/Versions/1.5/Commands/java'
alias java16='/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Commands/java'

alias unsafe_git='env GIT_SSL_NO_VERIFY=true git'

alias recursive_svnignore='foreach dir (**) [ -d $dir ] && echo "--- $dir ---" && svn propget svn:ignore $dir 2>/dev/null; end'

#----------------------------------------------------------------------
# Some custom functions
#----------------------------------------------------------------------

# When building an Android SDK project
function build_android_project {
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
function pylist {
	python -c "import $1; print str.join('\n', dir($1))"
}

# Total line count in files
function lc {
	echo "Total # Lines: " `cat $@ 2>/dev/null | wc -l`
}

# Total line count for source files of a given type
function lc4type { 
	TYPES=`echo "$@" | sed 's/ /" -or -name "*./g'`
	TYPES="-name \"*.${TYPES}\""
	echo 'Total # Lines: ' `eval "find . ${TYPES}" | sed -e'/\.svn/d' -e'/build/d' | sed 's/\(.*\)/\"\1\"/' | xargs cat 2>/dev/null | sed '/^[ \t]*$/d' | wc -l`
}

# Total line count for files on STDIN 
function lc4files {
	echo 'Total # Lines: ' `cat /dev/stdin | sed -e'/\.svn/d' -e'/build/d' | sed 's/\(.*\)/\"\1\"/' | xargs cat 2>/dev/null | wc -l`
}

#----------------------------------------------------------------------
# Other stuff
#----------------------------------------------------------------------
export EDITOR='vim'
export GREP_OPTIONS='--color=always'
export PIP_DOWNLOAD_CACHE="${HOME}/.pip/cache"
export SSH_ASKPASS='/usr/libexec/ssh-askpass'
export DISPLAY=':0'
export JAVA_HOME='/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home'

#----------------------------------------------------------------------
# For homebrew
#----------------------------------------------------------------------
if command -v brew &>/dev/null
then
	export HOMEBREW_PREFIX=`brew --prefix`

	export C_INCLUDE_PATH="${HOMEBREW_PREFIX}/include"
	export CPLUS_INCLUDE_PATH="${HOMEBREW_PREFIX}/include"
	export LIBRARY_PATH="${HOMEBREW_PREFIX}/lib:${LIBRARY_PATH}"
	export DYLD_FALLBACK_LIBRARY_PATH="${HOMEBREW_PREFIX}/lib:${HOMEBREW_PREFIX}:${DYLD_FALLBACK_LIBRARY_PATH}"

	export PYTHONPATH="${HOMEBREW_PREFIX}/lib/python2.7/site-packages:${PYTHONPATH}"
	export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${HOMEBREW_PREFIX}/share/python:${PATH}"
	export MANPATH="${HOMEBREW_PREFIX}/man:${MANPATH}"

	export BOOST_ROOT=`brew --prefix boost`
fi

#----------------------------------------------------------------------
# For virtualenv
#----------------------------------------------------------------------
if command -v virtualenv &>/dev/null
then
	export WORKON_HOME="${HOME}/.virtualenvs"
	export VIRTUALENVWRAPPER_PYTHON="${HOME}/usr/local/bin/python2.7"
	export PIP_VIRTUALENV_BASE="${WORKON_HOME}"
	export PIP_RESPECT_VIRTUALENV=true

	source virtualenvwrapper.sh
fi

#----------------------------------------------------------------------
# Load rvm functionality
#----------------------------------------------------------------------
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && . "${HOME}/.rvm/scripts/rvm"

#----------------------------------------------------------------------
# Include any local configuration (post profile)
#----------------------------------------------------------------------
[[ -e "${HOME}/.profile-post.local" ]] && . "${HOME}/.profile-post.local"

#----------------------------------------------------------------------
# If on a Mac, launchctl should be on path, so set up environment
# variables for it
#----------------------------------------------------------------------
if command -v launchctl &>/dev/null
then
	launchctl setenv PATH "$PATH"
	launchctl setenv C_INCLUDE_PATH "$C_INCLUDE_PATH"
	launchctl setenv CPLUS_INCLUDE_PATH "$CPLUS_INCLUDE_PATH"
	launchctl setenv LIBRARY_PATH "$LIBRARY_PATH"
	launchctl setenv DYLD_FALLBACK_LIBRARY_PATH "$DYLD_FALLBACK_LIBRARY_PATH"
	launchctl setenv BOOST_ROOT "$BOOST_ROOT"
fi

