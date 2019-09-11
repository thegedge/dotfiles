# Load library functions
for lib in "${HOME}/lib/"*; do
  source "${lib}"
done

# Ensure environment loads first
if [[ -e "${HOME}/profile/env" ]]; then
  source "${HOME}/profile/env"
fi

# Custom local profile that should exist outside of the repo
if [[ -e "${HOME}/.profile.local" ]]; then
  source "${HOME}/.profile.local"
fi

if [[ -e "${HOME}/profile/profile.d" ]]; then
  for file in $(find "${HOME}/profile/profile.d" -mindepth 1 -maxdepth 1 -type f -not -name '*.zwc' | sort); do
    source "${file}"
  done
fi

if [[ -e /Users/gedge/.nix-profile/etc/profile.d/nix.sh ]]; then
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh";
fi

# Clean up PATH
#  - remove duplicates
#  - remove trailing separator
#  - remove empt PATH components (which can be resolved to current working directory)
#
PATH="$(printf "%s" "${PATH}" | awk -v RS=':' -v ORS=':' '!a[$0]++' | sed -e 's/:+/:/g' -e 's/:$//')"
