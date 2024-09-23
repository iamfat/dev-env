# 嵌入式安装环境

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
