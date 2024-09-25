#!/bin/zsh

if [ -f "/opt/X11/bin/xquartz" ];
then
    echo "XQuartz 已安装"
else
    echo "安装XQuartz, 之后请先重启!!!"
    brew install --cask xquartz
fi

if [ -f "$(brew --prefix)/bin/socat" ];
then
    echo "socat 已安装"
else
    echo "安装 socat..."
    brew install socat
fi

X11FORWARD="cn.genee.X11Forward"
if [ $(launchctl list|grep $X11FORWARD|cut -f3) = "$X11FORWARD" ]; 
then
    echo "X11Forward 已加载"
else
    echo "加载 X11Forward..."
    BASE=$(dirname ${(%):-%N})
    cp "$BASE/$X11FORWARD.plist" "$HOME/Library/LaunchAgents/"
    launchctl load -w "$HOME/Library/LaunchAgents/$X11FORWARD.plist"
fi