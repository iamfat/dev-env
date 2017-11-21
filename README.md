# 开发环境安装文档

## 1. 环境准备
```bash
# switch default shell to bash
chsh -s /bin/bash

# install command-line tools
xcode-select --install

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install homebrew caskroom
brew tap caskroom/cask
```

## 2. 安装一些软件
```bash
# install fasd for fast directory locationing
brew install fasd
# install necessary softwares
brew cask install iterm2 sequel-pro docker the-unarchiver virtualbox vagrant visual-studio-code
# install fonts (optional)
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
```

## 3. 安装开发环境
```bash
# 通用数据目录
mkdir -p $HOME/Codes/data
# Gini模块目录
mkdir -p $HOME/Codes/data/gini-modules
# Node应用目录
mkdir -p $HOME/Codes/data/node
# 容器配置目录
git clone https://github.com/iamfat/dev-containers $HOME/Codes/data/containers
bash $HOME/Codes/data/containers/init.bash
```