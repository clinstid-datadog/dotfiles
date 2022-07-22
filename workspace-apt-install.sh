#!/bin/bash
sudo apt -y update && sudo apt -y install \
    build-essential \
    bundler \
    exuberant-ctags \
    grpcurl \
    htop \
    liblz4-dev \
    localehelper \
    lsof \
    mosh \
    mtr \
    neovim \
    psmisc \
    rake \
    silversearcher-ag \
    socat \
    telnet \
    tmux

# install pyenv
curl https://pyenv.run | bash
