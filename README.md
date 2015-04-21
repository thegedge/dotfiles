My personal dotfiles. Comes with:
- a personal shell configuration, centered around __[Zsh](http://www.zsh.org/)__,
- __[Oh My Zsh](//github.com/robbyrussell/oh-my-zsh)__ (zsh helper),
- __[Vundle](//github.com/gmarik/Vundle.vim)__ (vim plugin manager),
- a personal __vim__ configuration,
- a personal __git__ configuration, with commong ignore patterns, and
- a personal __[tmux](http://tmux.sourceforge.net/)__ configuration.

# Installation
The dotfiles comes with an [`install.sh`](install.sh "Install script") script.
```
curl -L https://github.com/thegedge/dotfiles/blob/master/install.sh | sh
```
The installation script does a few things like:
- check out some repositories, if necessary,
- create symbolic links to the dotfiles,
- install Oh My Zsh, and
- install Vundle and plugins specified in `vimrc`.
None of these steps are destructive (i.e., will prefer keeping existing files).
