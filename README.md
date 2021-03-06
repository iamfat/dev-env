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
brew tap homebrew/cask
```

## 2. 安装一些支持软件
```bash
# 安装 fasd 用于目录快速定位, 具体可见 https://github.com/clvv/fasd
brew install fasd
# 安装常用工具
brew cask install iterm2 sequel-pro the-unarchiver
# 安装Docker环境
brew cask install docker
# 安装IDE
brew cask install visual-studio-code
# 安装自带图标的字体, 用于优化terminal中的显示 (可选)
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
```

## 3. Web开发环境
```bash
# 在APFS Container中建立一个代码专用卷, 一般系统的Container是disk1, 如果有不同则自行调整
diskutil apfs addVolume disk1 APFSX Codes
# 通用数据目录
mkdir -p "/Volumes/Codes"
# 容器配置目录
git clone https://github.com/iamfat/dev-env "$HOME/Codes/dev-env"
bash "$HOME/Codes/dev-env/init.bash"

# 配置nfs服务器, 让docker容器能够通过nfs volume访问
echo "/Volumes/Codes -alldirs -maproot=root:wheel" | sudo tee /etc/exports
echo "nfs.server.mount.require_resv_port = 0" | sudo tee -a /etc/nfs.conf
sudo nfsd restart

docker-compose up -d -f web/docker-compose.yml

# 在克隆 gini 框架到 gini-modules 后并添加 .profile 脚本后可以直接使用dg来操作gini容器, dn来操作node容器
dg gini -v
dn npm -v
```

## 4. 嵌入式安装环境
我们使用VSCode+gdb+JLink进行调试
```bash
brew cask install gcc-arm-embedded
brew cask install segger-jlink
```
在开发项目里需要配置VSCode的调试配置
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
GDB为了在VSCode调用必须经过代码签名, 请首先使用`钥匙链访问 > 证书助理 > 创建一个证书... ` 建立用于GDB的证书, 确保证书用途是用于`代码签名`, 然后生成证书后把证书移动到`系统`, 之后运行下列命令
```bash
# GDB是证书的名字, 你可以在创建证书时自行命名, 之后这里用对应的名字即可
codesign -s GDB arm-none-eabi-gdb
```
使用JLink去开启调试程序
```bash
# 使用JLinkGDBServer开启远程gdb服务, 然后使用vscode连接
JLinkGDBServer -device STM32F103CB -speed 500 -if swd -port 2331
```

## 5. 运维工具
1. `ssh_sessions`: 从主机登录记录`/var/log/auth.log.*`中提取ssh登录情况
```bash
# install via curl
# Usage: sudo cat /var/log/auth.log | ssh_sessions [-u USER]
#     or sudo ssh_sessions [-u USER] /var/log/auth.log
sudo sh -c 'curl -sLo /usr/local/bin/ssh_sessions https://raw.githubusercontent.com/iamfat/dev-env/master/%40utils/ssh_sessions && chmod +x /usr/local/bin/ssh_sessions'
```