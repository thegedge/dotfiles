My personal dotfiles. Comes with:
- a personal shell configuration, centered around __[Zsh](http://www.zsh.org)__,
- __[vim-plug](//github.com/junegunn/vim-plug)__ (plugin manager for Vim),
- a personal __[vim](//vim.org)__ configuration,
- a personal __[git](//git-scm.com)__ configuration, with commong ignore patterns, and
- a personal __[tmux](http://tmux.sourceforge.net/)__ configuration.

# Installation

```sh
git clone --bare https://github.com/thegedge/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles checkout master
exec zsh
dotfiles submodule update --init
dotfiles config --local status.showUntrackedFiles no
vim +PlugUpdate
exec zsh
```
