#!/bin/zsh

function download {
  if [[ ! -e "${FLAG_dotfiles_dir}" ]]; then
    echo -e "---> \e[92mFetching dotfiles repo...\e[0m"
    git clone 'https://github.com/thegedge/dotfiles.git' "${FLAG_dotfiles_dir}"
  fi
}

function install_links {
  # Symbolic links to the dotfiles
  echo -e "---> \e[92mLinking dotfiles...\e[0m"
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

function zsh_setup {
  # Install oh-my-zsh (zsh plugins and such)
  if [[ ! -e "${HOME}/.oh-my-zsh" ]]; then
    echo -e "---> \e[92mFetching and installing oh-my-zsh...\e[0m"
    curl -L "https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh" | sh
    [[ -e "${HOME}/.zshrc.pre-oh-my-zsh" ]] && mv "${HOME}/.zshrc.pre-oh-my-zsh" "${HOME}/.zshrc"
  fi
}

function vim_setup {
  # Install vundle (vim plugin manager)
  if [[ ! -e "${HOME}/.vim/bundle/Vundle.vim" ]]; then
    echo -e "---> \e[92mFetching and installing Vundle...\e[0m"
    git clone "https://github.com/gmarik/Vundle.vim.git" "${HOME}/.vim/bundle/Vundle.vim"
  fi

  echo -e "---> \e[92mInstalling vundle plugins...\e[0m"
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
  #zsh_setup
  #vim_setup
}

main "$@"
