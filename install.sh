#!/bin/bash

set -ex

header() {
echo -e "\n\n\n\n\n\t\t\t$1\n\n\n\n\n"
}

# basic apt-get stuff
header "BASIC APT GET"
sudo apt-get update
sudo apt-get -fy install \
    curl wget net-tools dnsutils \
    apt-file git build-essential \
    apt-transport-https ca-certificates \
    curl gnupg-agent rsync mtr gwhois \
    software-properties-common psmisc \
    openssh-server openssh-client \
    mlocate \
    autoconf vim-gtk xorg zsh
sudo apt-file update

# set up directories
header "SETUP DIRECTORIES"
mkdir -p ~/workspace/{personal,work}
mkdir ~/github.com
mkdir ~/.ssh/

# copy home dir
header "COPY HOME"
cp -r ./home/. ~

# allow bitmap fonts
sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf

# install oh my zsh
header "INSTALL OH MY ZSH"
rm -rf ~/.oh-my-zsh
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install oh my zsh plugins
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
mkdir ~/.bash_completion.d/
# re-copy .zshrc
cp ./home/.zshrc ~/
# re-copy themes/
cp -r ./home/.oh-my-zsh/themes/. ~/.oh-my-zsh/themes/
# re-copy custom/
cp -r ./home/.oh-my-zsh/custom/. ~/.oh-my-zsh/custom/

# install i3gaps
header "INSTALL I3GAPS"
git clone https://github.com/Airblader/i3 ~/github.com/i3gaps
cd ~/github.com/i3gaps
# dependencies
sudo apt-get -fy install \
    dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev
# build
autoreconf --force --install
rm -rf build/
mkdir -p build/ && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make -j8
sudo make install
cd .. && rm -rf build
cd ~/.rice

# install nvm
header "INSTALL NVM"
NVM_VERSION=v0.35.3
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
export NVM_DIR="/home/dt/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install --lts
nvm use --lts

# install go
header "INSTALL GO"
GO_VERSION=1.14.7
GO_OS=linux
GO_ARCH=amd64
wget https://golang.org/dl/go$GO_VERSION.$GO_OS-$GO_ARCH.tar.gz
sudo tar -C /usr/local -xzf go$GO_VERSION.$GO_OS-$GO_ARCH.tar.gz
mkdir ~/go/
rm go$GO_VERSION.$GO_OS-$GO_ARCH.tar.gz

# install python
sudo apt-get install python python3 python3-pip python-pip

# install docker
header "INSTALL DOCKER"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -fy install docker-ce docker-ce-cli containerd.io

# install chrome
header "INSTALL CHROME"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt -fy install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# install polybar
header "INSTALL POLYBAR"
sudo apt-add-repository 'deb http://deb.debian.org/debian buster-backports main contrib non-free'
sudo apt-add-repository 'deb-src http://deb.debian.org/debian buster-backports main contrib non-free'
sudo apt-get update
sudo apt -t buster-backports -fy install polybar

# install a bunch of sweet stuff
header "INSTALL MISC"
# misc
sudo apt-get -fy install \
   dmenu ncmpcpp terminator autojump \
   feh nautilus gpicview gsimplecal \
   gnome-screenshot redshift xcompmgr \
   xbindkeys
# potato timer
npm i -g potato-timer
# mopidy
sudo apt-get -fy install mopidy
sudo python3 -m pip install Mopidy-GMusic
sudo python3 -m pip install Mopidy-MPD
# i3lock-multimonitor
sudo apt-get -fy install imagemagick i3lock
git clone https://github.com/shikherverma/i3lock-multimonitor.git ~/github.com/i3lock-multimonitor
cp -r ~/github.com/i3lock-multimonitor ~/.i3
chmod +x ~/.i3/i3lock-multimonitor/lock
# pulseaudio / pulseeffects
sudo apt-get remove libpulse0
sudo apt-get -fy install pulseeffects pulseaudio
# dunst
sudo apt-get -fy install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
git clone https://github.com/dunst-project/dunst.git ~/github.com/dunst
cd ~/github.com/dunst
make
sudo make install
make dunstify
cp -vs $(pwd)/dunstify ~/.local/bin/
cd ~/.rice

# update mlocate db
sudo updatedb
