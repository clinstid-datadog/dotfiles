#!/bin/bash
BASEDIR=$(dirname $(readlink -f "$0"))

mkdir -p ~/bin

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
    fd-find \
    direnv \
    ripgrep

sudo apt -y remove fzf

pushd /tmp
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
pushd $HOME
tar xvf /tmp/nvim-linux-x86_64.tar.gz
ln -svf ~/nvim-linux-x86_64/bin/nvim ~/bin/nvim
popd
popd

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

pip3 install --user git-machete

pip3 install dotdrop
dotdrop install -f -p workspace

if [ ! -x ~/bin/kubectx ] || [ ! -x ~/bin/kubens ]; then
    rm -rf /tmp/kubectx
    git clone https://github.com/ahmetb/kubectx /tmp/kubectx
    cp /tmp/kubectx/kubectx ~/bin
    cp /tmp/kubectx/kubens ~/bin
    rm -rf /tmp/kubectx
fi

# Bazel setup for vscode
if [ ! -x ~/go/bin/buildifier ]; then
    go install github.com/bazelbuild/buildtools/buildifier@latest
fi

if [ ! -x ~/.local/bin/starpls ]; then
    curl -s -L -o ~/.local/bin/starpls https://github.com/withered-magic/starpls/releases/latest/download/starpls-linux-amd64 && chmod +x ~/.local/bin/starpls
fi



sudo chsh -s /bin/zsh $(whoami)

ln -sf ~/dd ~/src

~/bin/nvim --headless +PlugInstall +qa

git remote set-url origin git@github.com:clinstid-datadog/dotfiles

go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
