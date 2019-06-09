#!/bin/bash

if [[ -e "$HOME/.bashenv" ]]; then
  source "$HOME/.bashenv"
fi

if [[ -e "$HOME/.profile" ]]; then
  source "$HOME/.profile"
fi

if [[ -e "$HOME/.bashrc.local" ]]; then
  source "$HOME/.bashrc.local"
fi

if [[ -e "$HOME/.fzf.bash" ]]; then
  source "$HOME/.fzf.bash"
fi
