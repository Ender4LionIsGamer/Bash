echo "Welcome To Lua Installer..."
echo "Starting...."

echo "What is your package manager? >> "
read package

echo "Step[1/5] Installing requirements..."
sudo $package install build-essential tar -y > install.log
touch install.log
touch uninstall.log
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
cd ~/Downloads
curl -o lua.tar.gz "http://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz" > install.log

echo "Step [4/5] Installing lua...."
mkdir lua-src > install.log
tar xf lua.tar.gz --strip-components=1 -C lua-src > install.log
cd lua-src
make -j$(nproc) > install.log
make install INSTALL_TOP=~/lua/usr/local > install.log
cd ~
mkdir lua/DEBIAN
echo "Package: lua" >> lua/DEBIAN/control
echo "Version: ${LUA_VERSION}-1" >> lua/DEBIAN/control
echo "Architecture: amd64" >> lua/DEBIAN/control
echo "Maintainer: $USER@$HOSTNAME" >> lua/DEBIAN/control
echo "Description: Lua programming language" >> lua/DEBIAN/control
dpkg-deb --build lua lua.deb > install.log
	
sudo apt install -y ./lua.deb > install.log

echo "Step [5/5] Packing up....."
rm -rf lua.tar.gz
rm -rf lua-src
rm -rf lua
rm -rf lua.deb

lua="lua -v"

echo "Done!"
echo "Now run $lua."
echo "If it fails, please rerun the script"