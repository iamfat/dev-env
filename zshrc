export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Homebrew
BREW_PREFIX=/opt/homebrew
export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
export PATH="$BREW_PREFIX/opt/python3/libexec/bin:$BREW_PREFIX/opt/coreutils/libexec/gnubin:$BREW_PREFIX/bin:$PATH"
export PKG_CONFIG_PATH="$BREW_PREFIX/opt/libffi/lib/pkgconfig"

eval "$(zoxide init zsh)"

export CONTAINER_CLI=docker

ENV_DIR=$(dirname ${(%):-%N})

source $ENV_DIR/net/zshrc

# 如果需要使用某个环境，请取消注释
source $ENV_DIR/android/zshrc
source $ENV_DIR/js/zshrc
source $ENV_DIR/php/zshrc
source $ENV_DIR/rust/zshrc
source $ENV_DIR/python/zshrc
source $ENV_DIR/vpn/zshrc
