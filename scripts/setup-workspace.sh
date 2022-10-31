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
    exuberant-ctags

pushd /tmp
curl -LO https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
popd

sudo unminimize
