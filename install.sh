#!/bin/sh

# If dotfiles don't already exist, clone repo
# TODO perhaps check pwd to see if some files exist so that one could instead clone into
#      into a different directory other than $HOME/dotfiles
if [ ! -e "$HOME/dotfiles" ]; then
	echo -e "---> \e[92mFetching dotfiles repo...\e[0m"
    git clone 'https://github.com/thegedge/dotfiles.git' $HOME/dotfiles
fi

# Symbolic links to the dotfiles
echo -e "---> \e[92mLinking dotfiles...\e[0m"
FILES=(profile gitconfig gitignore_global tmux.conf vimrc zprofile zshrc vim)
for fname in "${FILES[@]}"; do
    if [ ! -e $HOME/.$fname ]; then
		echo "Linking .$fname"
    	ln -s $HOME/dotfiles/$fname $HOME/.$fname
    fi
done

# Install oh-my-zsh (zsh plugins and such)
if [ ! -e "$HOME/.oh-my-zsh" ]; then
	echo -e "---> \e[92mFetching and installing oh-my-zsh...\e[0m"
	curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	[ -e "$HOME/.zshrc.pre-oh-my-zsh" ] && mv $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc
fi

# Install vundle (vim plugin manager)
if [ ! -e "$HOME/.vim/bundle/Vundle.vim" ]; then
	echo -e "---> \e[92mFetching and installing Vundle...\e[0m"
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo -e "---> \e[92mInstalling vundle plugins...\e[0m"
vim +PluginInstall +qall
