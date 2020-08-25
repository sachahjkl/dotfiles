#!/bin/sh

mkdir -p "$HOME"/{Desktop,Documents,Downloads,Games,Pictures,Public,Templates,Videos,.config,.cache/zsh} $HOME/Code/repos
touch "${XDG_CACHE_DIR:-$HOME/.cache}"/zsh/history
git submodule update --init --recursive
cp -r ./.* $HOME
rm -rf $HOME/{.gitmodules,.git,deploy.sh}
