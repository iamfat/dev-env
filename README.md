# 开发环境安装文档

## 1. 环境准备

```zsh
# 安装基本开发工具
xcode-select --install

cat <<EOF >> $HOME/.zprofile
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
EOF

source $HOME/.zprofile

# 安装Homebrew包管理工具
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 替换国内镜像加速
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

# 安装Homebrew Caskroom
brew tap homebrew/cask

# 替换国内镜像加速
cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git

# 安装iTerm2作为命令行终端
brew install --cask iterm2

# 在APFS Container中建立一个代码专用卷, 一般系统的Container是disk1, 如果有不同则自行调整
diskutil list internal|grep "APFS Container Scheme"
# 会得到 0:      APFS Container Scheme -                      +245.1 GB   disk1 这样的输出
# 最后一个单词就是盘符
diskutil apfs addVolume disk1 APFSX Codes
# 通用数据目录
mkdir -p "/Volumes/Codes"
# 容器配置目录
git clone https://github.com/iamfat/dev-env "$HOME/Codes/dev-env"
```

## 2. 使用iTerm2安装一些支持软件

```bash
# 终端美化
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 手动设置iTerm的字体为Hack Nerd, 用于进行带图标的字体显示
cat <<EOF >> ~/.oh-my-zsh/custom/themes/genee.zsh-theme
PROMPT="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"
PROMPT+=' %{$fg[cyan]%}  %c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%} %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"
EOF

sed -e 's/ZSH_THEME=.*/ZSH_THEME=genee/g' ~/.zshrc

# 安装 fasd 用于目录快速定位, 具体可见 https://github.com/clvv/fasd
brew install fasd

# # 安装Docker环境
# brew install --cask docker
# # 配置nfs服务器, 让Docker容器能够通过NFS访问开发卷
# echo "/Volumes/Codes -alldirs -maproot=root:wheel" | sudo tee /etc/exports
# echo "nfs.server.mount.require_resv_port = 0" | sudo tee -a /etc/nfs.conf
# sudo nfsd restart

# 安装IDE
brew install --cask visual-studio-code
```

## 3. 初始化开发环境

```bash
# 如果你用ZSH
echo "source /Volume/Codes/zshrc" >> ~/.zshrc

# 如果你用BASH
echo "source /Volume/Codes/bashrc" >> ~/.bashrc

```

## 4. 嵌入式安装环境

我们使用 VSCode+gdb+JLink 进行调试

```bash
brew cask install gcc-arm-embedded
brew cask install segger-jlink
```

在开发项目里需要配置 VSCode 的调试配置

```json
{
  // demo file in .vscode/launch.json
  "version": "0.2.0",
  "configurations": [
    {
      "name": "JLink Launch",
      "type": "cppdbg",
      "request": "launch",
      "program": "${workspaceFolder}/build/YOUR.elf",
      "args": [],
      "stopAtEntry": false,
      "cwd": "${workspaceFolder}",
      "environment": [],
      "externalConsole": false,
      "MIMode": "gdb",
      "miDebuggerPath": "/usr/local/bin/arm-none-eabi-gdb",
      "miDebuggerServerAddress": "localhost:2331"
    }
  ]
}
```

GDB 为了在 VSCode 调用必须经过代码签名, 请首先使用`钥匙链访问 > 证书助理 > 创建一个证书... ` 建立用于 GDB 的证书, 确保证书用途是用于`代码签名`, 然后生成证书后把证书移动到`系统`, 之后运行下列命令

```bash
# GDB是证书的名字, 你可以在创建证书时自行命名, 之后这里用对应的名字即可
codesign -s GDB arm-none-eabi-gdb
```

使用 JLink 去开启调试程序

```bash
# 使用JLinkGDBServer开启远程gdb服务, 然后使用vscode连接
JLinkGDBServer -device STM32F103CB -speed 500 -if swd -port 2331
```

## 5. 运维工具

1. `ssh_sessions`: 从主机登录记录`/var/log/auth.log.*`中提取 ssh 登录情况

```bash
# install via curl
# Usage: sudo cat /var/log/auth.log | ssh_sessions [-u USER]
#     or sudo ssh_sessions [-u USER] /var/log/auth.log
sudo sh -c 'curl -sLo /usr/local/bin/ssh_sessions https://raw.githubusercontent.com/iamfat/dev-env/master/%40utils/ssh_sessions && chmod +x /usr/local/bin/ssh_sessions'
```

## 6. Android 开发环境

1. 下载[Android Command Line Tools](https://developer.android.com/studio#cmdline-tools)
2. 解压下载的zip文件
3. 使用终端进入解压目录
    ```bash
    mkdir -p $HOME/Library/Android/sdk
    tools/bin/sdkmanager —sdk_root=$HOME/Library/Android/sdk "commandline-tools;latest"
    cd $HOME/Library/Android/sdk/cmdline-tools/latest/bin
    ./sdkmanager "build-tools;29.0.2"
    ./sdkmanager "platforms;android-28"
    ```