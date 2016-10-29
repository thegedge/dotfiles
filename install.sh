#!/bin/zsh

function download {
  if [[ ! -e "${FLAG_dotfiles_dir}" ]]; then
    echo -e "--->\e[92m Fetching dotfiles repo...\e[0m"
    git clone --recursive 'https://github.com/thegedge/dotfiles.git' "${FLAG_dotfiles_dir}"
  fi
}

function install_links {
  # Symbolic links to the dotfiles
  echo -e "--->\e[92m Linking dotfiles...\e[0m"
  for link_file in $(find "${FLAG_dotfiles_dir}" -name links); do
    cat "${link_file}" | while read link_data; do
      local -a link_spec; link_spec=( "${(@s/ -> /)link_data}" )
      local -a link_srcs; link_srcs=( $(eval "echo $(dirname ${link_file})/${link_spec[1]}") )
      local link_dest=$(eval "echo ${link_spec[2]}")

      local link_flags='-ns'
      if [[ FLAG_override_links -ne 0 ]]; then
        link_flags="${link_flags} -f"
      fi

      for link_src in "${link_srcs[@]}"; do
        echo "\e[36m " ln ${link_flags} "${link_src}" "${link_dest}" "\e[0m"
        mkdir -p "$(dirname "${link_dest}")"
        ln ${link_flags} "${link_src}" "${link_dest}" &>/dev/null
      done
    done
  done
}

function install_powerline_fonts {
  echo -e "--->\e[92m Installing powerline fonts...\e[0m"
  git clone --depth=1 'https://github.com/powerline/fonts.git' "$TMPDIR/powerline-fonts"
  $TMPDIR/powerline-fonts/install.sh
  rm -rf "$TMPDIR/powerline-fonts"
}

function install_env {
  echo "$FLAG_dotfiles_dir" >> "${ZDOTDIR:-$HOME}/.zshenv"
}

function vim_setup {
  echo -e "--->\e[92m Installing vundle plugins...\e[0m"
  vim +PluginInstall +qall
}

function parse_args {
  FLAG_dotfiles_dir="${HOME}/dotfiles"
  FLAG_actions=(download link fonts env vim)
  FLAG_override_links=0

  for flag in "$@"; do
    case "${flag}" in
      --dotfiles-dir)
        FLAG_dotfiles_dir="$1"
        shift
        ;;
      --override-links)
        FLAG_override_links=1
        shift
        ;;
      --only-link)
        FLAG_actions=(link)
        shift
        ;;
      *)
        echo "Unknown option: ${flag}"
        exit 1
        ;;
    esac
  done
}

includes() {
  local e
  for e in "${@:2}"; do
    [[ "$e" == "$1" ]] && return 0;
  done
  return 1
}

main() {
  parse_args "$@"
  includes download "${FLAG_actions[@]}" && download
  includes link "${FLAG_actions[@]}"     && install_links
  includes fonts "${FLAG_actions[@]}"    && install_powerline_fonts
  includes env "${FLAG_actions[@]}"      && install_env
  includes vim "${FLAG_actions[@]}"      && vim_setup
}

main "$@"
