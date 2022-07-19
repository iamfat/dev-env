export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

eval "$(fasd --init auto)"

# Android
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$HOME/Library/Android/sdk"
alias adb="$ANDROID_SDK_ROOT/platform-tools/adb"
alias adbrr="adb shell input text rr"
alias adbd="adb shell input keyevent 82"

export JAVA_HOME="$HOME/Library/Java/JavaVirtualMachines/azul-16.0.2/Contents/Home"

# Homebrew
BREW_PREFIX=$(brew --prefix)
export PATH="$BREW_PREFIX/sbin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$BREW_PREFIX/opt/python@3.10/libexec/bin:$PATH"

export PKG_CONFIG_PATH="$BREW_PREFIX/opt/libffi/lib/pkgconfig"

export NVM_DIR="$HOME/.nvm"
[ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && . "$BREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

YARN_BIN=$(yarn global bin)
export PATH="$YARN_BIN:$PATH"

# source php/zshrc