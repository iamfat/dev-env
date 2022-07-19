export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

eval "$(fasd --init auto)"

# Homebrew
BREW_PREFIX=$(brew --prefix)
export PATH="$BREW_PREFIX/sbin:$PATH"

# source java/zshrc
# source js/zshrc
# source php/zshrc

