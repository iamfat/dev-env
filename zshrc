export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

eval "$(fasd --init auto)"

# Homebrew
BREW_PREFIX=$(brew --prefix)
export PATH="$BREW_PREFIX/sbin:$PATH"

ENV_DIR=$(dirname ${(%):-%N})

# source $ENV_DIR/java/zshrc
# source $ENV_DIR/js/zshrc
# source $ENV_DIR/php/zshrc

