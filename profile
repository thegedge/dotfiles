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
alias sedi="sed -i ''"                  # in-place sed

alias java14='/System/Library/Frameworks/JavaVM.framework/Versions/1.4/Commands/java'
alias java15='/System/Library/Frameworks/JavaVM.framework/Versions/1.5/Commands/java'
alias java16='/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Commands/java'

# Upgrade all Pip packages
alias pipupgrade="pip freeze --local | grep -v '^-e' | cut -d = -f 1 | sed '/vboxapi/d' | xargs pip install -U"

# Use LibClang with Python
alias clangpy="LD_LIBRARY_PATH=$(brew --prefix llvm)/lib/ PYTHONPATH=$(brew --prefix llvm)/lib/python2.7/site-packages python"

# Syntax highlighting with less
function hilite {
	less -f -x2 <(type pygmentize &>/dev/null && pygmentize -f terminal "$1" || cat "$1")
}

#----------------------------------------------------------------------
# Some custom functions
#----------------------------------------------------------------------

# List the contents of a module
function pylist {
	python -c "import $1; print str.join('\n', dir($1))"
}

# Filters lines that we typically don't want to count
function _count_lines {
	if command -v cloc &>/dev/null
	then
		sed -e'/\.svn/d' -e'/\.git/d' -e'/build/d' /dev/stdin \
			| sed 's/\(.*\)/\"\1\"/' \
			| xargs cloc 2>/dev/null
	else
		sed -e'/\.svn/d' -e'/\.git/d' -e'/build/d' /dev/stdin \
			| sed 's/\(.*\)/\"\1\"/' \
			| xargs cat 2>/dev/null \
			| sed '/^[ \t]*$/d' \
			| sed -E '/^[ \t]*\/\//d' \
			| wc -l
	fi
}

# Total line count for source files of a given type
function lc4type { 
	local TYPES
	TYPES=$(echo "$@" | sed 's/ /" -or -name "*./g')
	TYPES="-name \"*.${TYPES}\""
	eval "find . $TYPES" | _count_lines
}

# Use install_name_tool to modify all things with a given prefix
function change_prefixes {
	local FILE=$1
	local OLD_PREFIX=$2
	local NEW_PREFIX=$3

	if [ ! command -v otool &>/dev/null -o ! command -v install_name_tool &>/dev/null ]
	then
		echo "test"
	elif [ ! -e $FILE ]
	then
		echo "'$FILE' does not exist"
	else
		otool -L "$FILE" 2>/dev/null | grep --colour=never "$OLD_PREFIX" | while read -r line
		do
			local piece="$(echo $line | cut -f1 -d\ )"
			install_name_tool -change "$piece" "${NEW_PREFIX}${piece#$OLD_PREFIX}" $FILE
		done
	fi
}

# Recursively download a webpage
function recursive_download_webpage {
	wget --recursive \
	     --no-clobber \
	     --page-requisites \
	     --html-extension \
	     --convert-links \
	     --restrict-file-names=windows \
	     --domains ${2-:''} \
	     --no-parent \
	     $1
}

# Generates a PNG for a given LaTeX math formula
function texify {
	local fname=${3:-formula.png}
	local url=$(python -c 'import urllib,sys;print urllib.quote(sys.argv[1])' "$1")
	url="http://latex.codecogs.com/png.latex?\\dpi\{${2:-150}\}&$url"
	curl "$url" --silent -o "${fname%.png}.png"
}

function new_angular {
	git clone --depth=1 https://github.com/angular/angular-seed.git $1 \
		&& rm -rf ${1:-angular-seed}/.git \
		&& pushd ${1:-angular-seed}
}

#----------------------------------------------------------------------
# Other stuff
#----------------------------------------------------------------------
export EDITOR='vim'
export GREP_OPTIONS='--color=always'
export PIP_DOWNLOAD_CACHE="${HOME}/.pip/cache"
export SSH_ASKPASS='/usr/libexec/ssh-askpass'
export JAVA_HOME='/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home'

#----------------------------------------------------------------------
# For homebrew
#----------------------------------------------------------------------
if command -v brew &>/dev/null
then
	export HOMEBREW_PREFIX="$(brew --prefix)"

	#export C_INCLUDE_PATH="${HOMEBREW_PREFIX}/include"
	#export CPLUS_INCLUDE_PATH="${HOMEBREW_PREFIX}/include"
	#export LIBRARY_PATH="${HOMEBREW_PREFIX}/lib:${LIBRARY_PATH}"
	export DYLD_FALLBACK_LIBRARY_PATH="${HOMEBREW_PREFIX}/lib:${HOMEBREW_PREFIX}:${DYLD_FALLBACK_LIBRARY_PATH}"

	export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}"
	export MANPATH="${HOMEBREW_PREFIX}/man:${MANPATH}"

	export BOOST_ROOT="$(brew --prefix boost)"
	export ANDROID_HOME="$(brew --prefix android-sdk)"
fi

#----------------------------------------------------------------------
# For virtualenv
#----------------------------------------------------------------------
if command -v virtualenv &>/dev/null
then
	export WORKON_HOME="${HOME}/.virtualenvs"
	export VIRTUALENVWRAPPER_PYTHON="$(which python2.7)"
	export PIP_VIRTUALENV_BASE="${WORKON_HOME}"
	export PIP_RESPECT_VIRTUALENV=true

	source virtualenvwrapper.sh
fi

#----------------------------------------------------------------------
# Load cabal (Haskell) functionality
#----------------------------------------------------------------------
[[ -e "${HOME}/.cabal/bin" ]] && export PATH="${HOME}/.cabal/bin:${PATH}"

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
	launchctl setenv PATH "$PATH" 2>/dev/null
	launchctl setenv C_INCLUDE_PATH "$C_INCLUDE_PATH" 2>/dev/null
	launchctl setenv CPLUS_INCLUDE_PATH "$CPLUS_INCLUDE_PATH" 2>/dev/null
	launchctl setenv LIBRARY_PATH "$LIBRARY_PATH" 2>/dev/null
	launchctl setenv DYLD_FALLBACK_LIBRARY_PATH "$DYLD_FALLBACK_LIBRARY_PATH" 2>/dev/null
	launchctl setenv BOOST_ROOT "$BOOST_ROOT" 2>/dev/null
fi

