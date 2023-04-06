#!/bin/bash
curl -o /tmp/install-oh-my-zsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
KEEP_ZSHRC=yes sh /tmp/install-oh-my-zsh.sh

sudo apt -y update

sudo apt-get -y install \
    build-essential \
    bundler \
    htop \
    liblz4-dev \
    localehelper \
    lsof \
    mosh \
    mtr \
    psmisc \
    rake \
    silversearcher-ag \
    socat \
    telnet \
    tmux \
    elinks \
    bash-completion \
    file \
    exuberant-ctags

pushd /tmp
curl -LO https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
popd

sudo unminimize

mkdir -p ~/bin
pushd /tmp
wget https://github.com/aristocratos/btop/releases/latest/download/btop-x86_64-linux-musl.tbz
tar xvf btop-x86_64-linux-musl.tbz
pushd btop
./install.sh
rm -rf btop btop-x86_64-linux-musl.tbz
popd
