#----------------------------------------------------------------------
# Setting TRACING=1 will enable some tracing statements which help you
# profile slow parts of your zshrc.
#----------------------------------------------------------------------
if [[ -n "${TRACING}" ]]; then
  zmodload zsh/zprof
fi

# Speed up ZSH initialization by skipping global completion initialization
skip_global_compinit=1

if [[ -f "${HOME}/.zshenv.local" ]]; then
  source "${HOME}/.zshenv.local"
fi
