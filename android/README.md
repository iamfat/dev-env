# Android 开发环境

## 准备
```zsh
brew install android-commandlinetools android-platform-tools openjdk@17
```

## 项目整合
```zsh
echo "sdk.dir=$(brew --prefix)/share/android-commandlinetools" >> local.properties
```