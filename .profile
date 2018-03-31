# Load library functions
for lib in "$HOME/lib/"*; do
  source "${lib}"
done

# Ensure environment loads first
if [[ -e "$HOME/profile/env" ]]; then
  source "$HOME/profile/env"
fi

# Custom local profile that should exist outside of the repo
if [[ -e "$HOME/.profile.local" ]]; then
  source "$HOME/.profile.local"
fi

if [[ -e "$HOME/profile/profile.d" ]]; then
  for file in $(find "$HOME/profile/profile.d" -mindepth 1 -maxdepth 1 -type f -not -name '*.zwc' | sort); do
    unisource "${file}"
  done
fi

# Clean up path variable
export PATH="$(echo "${PATH}" | awk -v RS=':' -v ORS=':' '!a[$1]++ { print $1 }')"
