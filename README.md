My personal dotfiles. Comes with:
- a personal shell configuration, centered around __[Zsh](http://www.zsh.org/)__,
- the __[vim-plug](//github.com/junegunn/vim-plug)__ (plugin manager for Vim),
- a personal __vim__ configuration,
- a personal __git__ configuration, with commong ignore patterns, and
- a personal __[tmux](http://tmux.sourceforge.net/)__ configuration.

# Installation

The dotfiles comes with an [`install.sh`](install.sh "Install script") script
to simplify the process of getting up and running. If you like the YOLO
approach of bootstrapping:

```
curl -L https://raw.githubusercontent.com/thegedge/dotfiles/master/install.sh | sh
```

You can also download, verify, and manually run the script yourself, or pick
and choose which bits and pieces to execute. The installation script does a few
things like:

- check out some repositories, if necessary,
- create symbolic links to the dotfiles,
- install [Powerline fonts](//github.com/powerline/fonts),
- install vim-plug and plugins specified in `vimrc`.

None of these steps are destructive by default (i.e., will prefer keeping
existing files). Some flags:

- `--dotfiles-dir`, specify the directory to install the dotfiles to (default:
  `$HOME/dotfiles`).
- `--only-link`, only install symbolic links.
- `--override-links`, always force overwriting any existing symbolic links to
  various dotfiles (default: false).
