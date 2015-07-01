#!/bin/zsh

function download {
  if [[ ! -e "${FLAG_dotfiles_dir}" ]]; then
    echo -e "--->\e[92m Fetching dotfiles repo...\e[0m"
    git clone 'https://github.com/thegedge/dotfiles.git' "${FLAG_dotfiles_dir}"
  fi
}

function install_links {
  # Symbolic links to the dotfiles
  echo -e "--->\e[92m Linking dotfiles...\e[0m"
  for link_file in $(find "${FLAG_dotfiles_dir}" -name links); do
    cat "${link_file}" | while read link_data; do
      local -a link_spec; link_spec=( "${(@s/ -> /)link_data}" )
      local link_src=$(eval "echo $(dirname ${link_file})/${link_spec[1]}")
      local link_dest=$(eval "echo ${link_spec[2]}")
      if [[ FLAG_override_links -ne 0 || ( ! -e "${link_dest}" && -f "${link_src}" ) ]]; then
        echo "\e[36m " ln -nfs "${link_src}" "${link_dest}" "\e[0m"
        ln -nfs "${link_src}" "${link_dest}"
      fi
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
  FLAG_download=0
  FLAG_override_links=0

  for flag in "$@"; do
    case $flag in
      --dotfiles-dir)
        FLAG_dotfiles_dir="$1"
        shift
        ;;
      --download)
        FLAG_download=1
        shift
        ;;
      --override-links)
        FLAG_override_links=1
        shift
        ;;
      *)
        echo "Unknown option: ${flag}"
        exit 1
        ;;
    esac
  done
}

function main {
  parse_args "$@"
  download
  install_links
  install_powerline_fonts
  install_env
  vim_setup
}

main "$@"
