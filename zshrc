export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Homebrew
BREW_PREFIX=/opt/homebrew
export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
export PATH="$BREW_PREFIX/opt/python3/libexec/bin:$BREW_PREFIX/opt/coreutils/libexec/gnubin:$BREW_PREFIX/bin:$PATH"
export PKG_CONFIG_PATH="$BREW_PREFIX/opt/libffi/lib/pkgconfig"

eval "$(zoxide init zsh)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/mt.omp.json)"

# export CONTAINER_CLI=nerdctl.lima
# alias docker=nerdctl.lima

export CONTAINER_CLI=docker

ENV_DIR=$(dirname ${(%):-%N})

source $ENV_DIR/android/zshrc
source $ENV_DIR/js/zshrc
source $ENV_DIR/php/zshrc
source $ENV_DIR/rust/zshrc
source $ENV_DIR/vpn/zshrc