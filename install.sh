#!/bin/sh

# If dotfiles don't already exist, clone repo
# TODO perhaps check pwd to see if some files exist so that one could instead clone into
#      into a different directory other than $HOME/dotfiles
if [ ! -e "$HOME/dotfiles" ]
then
    git clone 'https://github.com/thegedge/dotfiles.git' $HOME/dotfiles
fi

# Symbolic links to the dotfiles
FILES=(profile gitconfig gitignore_global tmux.conf vimrc zprofile zshrc vim)
for fname in "${FILES[@]}"
do
    [ ! -e $HOME/.$fname ] && ln -s $HOME/dotfiles/$fname $HOME/.$fname
done

# Install oh-my-zsh (zsh plugins and such)
[ ! -e "$HOME/.oh-my-zsh" ] && curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Install vundle (vim plugin manager)
[ ! -e "$HOME/.vim/bundle/Vundle.bim" ] && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
