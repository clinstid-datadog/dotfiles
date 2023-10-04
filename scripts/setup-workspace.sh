#!/bin/bash
BASEDIR=$(dirname $(readlink -f "$0"))

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
    exuberant-ctags \
    fd-find

sudo apt -y remove fzf

pushd /tmp
NVIM_VERSION="v0.8.3"
curl -LO https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb
popd

# sudo unminimize

if [ ! -x /usr/local/bin/btop ]; then
    pushd /tmp
    wget https://github.com/aristocratos/btop/releases/latest/download/btop-x86_64-linux-musl.tbz
    tar xvf btop-x86_64-linux-musl.tbz
    pushd btop
    ./install.sh
    popd
    rm -rf btop btop-x86_64-linux-musl.tbz
    popd
fi

pip3 install dotdrop
dotdrop install -f -p workspace

cp $BASEDIR/clinstid-datadog-github_id_ed25519.pub ~/.ssh
chmod 0644 ~/.ssh/clinstid-datadog-github_id_ed25519.pub

mkdir -p ~/bin

if [ ! -x ~/bin/kubectx ] || [ ! -x ~/bin/kubens ]; then
    rm -rf /tmp/kubectx
    git clone https://github.com/ahmetb/kubectx /tmp/kubectx
    cp /tmp/kubectx/kubectx ~/bin
    cp /tmp/kubectx/kubens ~/bin
    rm -rf /tmp/kubectx
fi

if [ ! -x ~/go/bin/buildifier ]; then
    go install github.com/bazelbuild/buildtools/buildifier@latest
fi

sudo chsh -s /bin/zsh $(whoami)

ln -sf ~/dd ~/src

nvim --headless +PlugInstall +qa

git remote set-url origin git@github.com:clinstid-datadog/dotfiles
