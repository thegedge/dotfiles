#!/bin/zsh
switch_to_another_tmux_client() {
  # If inside tmux and closing off last shell in a session, switch to another
  if [[ -n "${TMUX}" ]]; then
    local num_panes="$(tmux list-panes | wc -l)"
    local num_windows="$(tmux list-windows | wc -l)"
    local num_sessions="$(tmux list-sessions | wc -l)"
    if [[ "${num_panes}" -eq 1 && "${num_windows}" -eq 1 && "${num_sessions}" -gt 1 ]]; then
      tmux switch-client -n
    fi
  fi
}

switch_to_another_tmux_client
