#!/bin/bash/
clear
echo "Please run this script as root!"
echo "Welcome To Lua Installer..."
echo "Starting...."

echo "What is your package manager? >> "
read package

echo "Step[1/5] Installing requirements..."
sudo $package install build-essential tar wget -y > /tmp/install.log
sudo touch /tmp/install.log
sudo touch /tmp/install.log
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'

echo "Step [2/5] Loading env..."
LUA_VERSION=$(curl -s "https://api.github.com/repos/lua/lua/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'

echo "Step [3/] Downloading lua..."
wget "http://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz"  > /tmp/install.log

echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'

echo "Step [4/5] Installing lua...."
cd ~/Downloads/
sudo mkdir lua-src > ~/tmp/install.log
sudo tar xf lua.tar.gz --strip-components=1 -C lua-src > /tmp/install.log
mkdir lua-src
cd lua-src
make -j$(nproc) > /tmp/install.log
make install INSTALL_TOP=~/lua/usr/local > /tmp/install.log
sudo mkdir lua/
sudo mkdir lua/DEBIAN
echo "Package: lua" >> lua/DEBIAN/control
echo "Version: ${LUA_VERSION}-1" >> lua/DEBIAN/control
echo "Architecture: amd64" >> lua/DEBIAN/control
echo "Maintainer: $USER@$HOSTNAME" >> lua/DEBIAN/control
echo "Description: Lua programming language" >> lua/DEBIAN/control
sudo dpkg-deb --build lua lua.deb > /tmp/install.log
	
sudo apt install -y ./lua.deb > /tmp/install.log

echo -ne '#####                     (33%)\r'
sleep 1
echo -ne '#############             (66%)\r'
sleep 1
echo -ne '#######################   (100%)\r'
echo -ne '\n'

echo "Step [5/5] Packing up....."
sudo rm -rf ~/Downloads/lua.tar.gz
sudo rm -rf ~/Downloads/lua-src
sudo rm -rf ~/Downloads/lua
sudo rm -rf ~/Downloads/lua.deb

lua="lua -v"

echo "Done!"
echo "Now run $lua."
echo "If it fails, please rerun the script"
