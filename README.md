My personal dotfiles. Comes with:
- a personal shell configuration, centered around __[Zsh](http://www.zsh.org)__,
- __[vim-plug](//github.com/junegunn/vim-plug)__ (plugin manager for Vim),
- a personal __[vim](//vim.org)__ configuration,
- a personal __[git](//git-scm.com)__ configuration, with commong ignore patterns, and
- a personal __[tmux](http://tmux.sourceforge.net/)__ configuration.

# Installation

## Basic setup

```sh
git clone --bare https://github.com/thegedge/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout master
exec zsh
dotfiles submodule update --init
dotfiles config --local status.showUntrackedFiles no
vim +UpdateRemotePlugins +PlugUpdate
exec zsh
```

## Powerline fonts

```sh
TMPDIR=/tmp
git clone --depth=1 'https://github.com/powerline/fonts.git' "$TMPDIR/powerline-fonts"
$TMPDIR/powerline-fonts/install.sh
rm -rf "$TMPDIR/powerline-fonts"
```
