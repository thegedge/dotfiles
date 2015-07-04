My personal dotfiles. Comes with:
- a personal shell configuration, centered around __[Zsh](http://www.zsh.org/)__,
- the __[Prezto](//github.com/sorin-ionescu/prezto)__ (zsh configuration framework),
- the __[Vundle](//github.com/gmarik/Vundle.vim)__ (plugin manager for Vim),
- a personal __vim__ configuration,
- a personal __git__ configuration, with commong ignore patterns, and
- a personal __[tmux](http://tmux.sourceforge.net/)__ configuration.

# Installation

The dotfiles comes with an [`install.sh`](install.sh "Install script") script
to simplify the process of getting up and running. If you like the YOLO
approach of bootstrapping:

```
curl -L https://github.com/thegedge/dotfiles/blob/master/install.sh | sh
```

You can also download, verify, and manually run the script yourself, or pick
and choose which bits and pieces to execute. The installation script does a few
things like:

- check out some repositories, if necessary,
- create symbolic links to the dotfiles,
- install [Powerline fonts](//github.com/powerline/fonts),
- install Prezto (recursively), and
- install Vundle and plugins specified in `vimrc`.

None of these steps are destructive by default (i.e., will prefer keeping
existing files). Some flags:

- `--download`, download git repo (default: false).
- `--dotfiles-dir`, specify the directory to install the dotfiles to (default:
  `$HOME/dotfiles`)
- `--override-links`, always force overwriting any existing symbolic links to
  various dotfiles (default: false).
