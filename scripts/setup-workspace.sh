#!/bin/bash
BASEDIR=$(readlink -f "$0")

set -x

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
NVIM_VERSION="v0.8.3"
curl -LO https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
popd

# sudo unminimize

mkdir -p ~/bin
pushd /tmp
wget https://github.com/aristocratos/btop/releases/latest/download/btop-x86_64-linux-musl.tbz
tar xvf btop-x86_64-linux-musl.tbz
pushd btop
./install.sh
popd
rm -rf btop btop-x86_64-linux-musl.tbz
popd

pip3 install dotdrop
dotdrop install -f -p workspace

cp scripts/clinstid-datadog-github_id_ed25519.pub ~/.ssh
chmod 0644 ~/.ssh/clinstid-datadog-github_id_ed25519.pub

sudo chsh -s /bin/zsh $(whoami)
