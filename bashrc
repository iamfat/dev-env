export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

eval "$(fasd --init auto)"

function __docker_exec_cmd() {
  local params=($@)
  local service=${params[0]}
  local container_id=$(docker container ps -f 'name='$service -q)
  if [ -z "$container_id" ]; then
    echo "Container \"*$service*\" was not found!"
    return 127
  else
    shift
    docker exec -it $container_id "$@"
  fi
}

alias de='__docker_exec_cmd'
alias ls="ls -G"

# Android
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$HOME/Library/Android/sdk"
alias adb="$ANDROID_SDK_ROOT/platform-tools/adb"
alias adbrr="adb shell input text rr"
alias adbd="adb shell input keyevent 82"

# Homebrew
BREW_PREFIX=$(brew --prefix)
export PATH="$BREW_PREFIX/opt/openjdk@11/bin:$PATH"
export PATH="$BREW_PREFIX/opt/python@3.9/libexec/bin:$PATH"

export PKG_CONFIG_PATH="$BREW_PREFIX/opt/libffi/lib/pkgconfig"

export NVM_DIR="$HOME/.nvm"
[ -s "$BREW_PREFIX/opt/nvm/nvm.sh" ] && . "$BREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
