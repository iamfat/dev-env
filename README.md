# 开发环境安装文档

## 1. 环境准备

```zsh
# 安装基本开发工具, 获取git
xcode-select --install

cat <<EOF >> $HOME/.zprofile
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"
EOF

source $HOME/.zprofile

# 安装Homebrew包管理工具
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git /tmp/brew-install
/bin/bash /tmp/brew-install/install.sh
rm -rf /tmp/brew-install

# 在APFS Container中建立一个代码专用卷, 一般系统的Container是disk1, 如果有不同则自行调整
DISK=$(diskutil list internal|grep "APFS Container Scheme"|cut -w f9)
diskutil apfs addVolume "$DISK" APFSX Codes

# 安装 zoxide 用于目录快速定位
brew install zoxide

# 安装 nodejs 环境
brew install fnm

# 安装Docker环境
brew install --cask docker

# 配置nfs服务器, 让Docker容器能够通过NFS访问开发卷
echo "/Volumes/Codes -alldirs -maproot=root:wheel" | sudo tee /etc/exports
echo "nfs.server.mount.require_resv_port = 0" | sudo tee -a /etc/nfs.conf
sudo nfsd restart

# 安装IDE
brew install --cask visual-studio-code

# 安装iTerm2作为命令行终端
brew install --cask iterm2

# 克隆开发环境的配置到dev-env
git clone https://github.com/iamfat/dev-env "$HOME/Documents/dev-env"
echo "source $HOME/Documents/dev-env/zshrc" >> ~/.zshrc

# 准备容器环境
bash $HOME/Documents/dev-env/init-containers.bash
```

## 2. 使用iTerm2安装一些支持软件
开启iTerm2, 在终端开始
```zsh
# 终端美化
brew install --cask font-jetbrains-mono-nerd-font

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 手动设置iTerm的字体为Hack Nerd, 用于进行带图标的字体显示
cat <<'EOF' > ~/.oh-my-zsh/custom/themes/genee.zsh-theme
PROMPT="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"
PROMPT+=' %{$fg[cyan]%}  %c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%} %{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"
EOF

sed -e 's/ZSH_THEME=.*/ZSH_THEME=genee/g' ~/.zshrc
```

## 3. 其他
1. [Android开发](./android/README.md)
2. [嵌入式开发](./embedded-env.md)