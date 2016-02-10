#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for fn in .bashrc .bash_profile .slate .slate.js .gitconfig .tmux.conf .git-prompt.sh; do
    echo "linking $fn in $HOME"
    rm -f $HOME/$fn
    ln -sf $THIS_DIR/$fn $HOME/$fn
done

echo "linking flake8 in $HOME/.config/flake8"
rm -f $HOME/.config/flake8
mkdir -p $HOME/.config
ln -sf $THIS_DIR/flake8 $HOME/.config/flake8

echo "linking .gitignore_global in $HOME/.gitignore"
rm -f $HOME/.gitignore
ln -sf $THIS_DIR/.gitignore_global $HOME/.gitignore

echo "linking ssh config"
rm -f $HOME/.ssh/rc
ln -sf $THIS_DIR/.ssh-rc $HOME/.ssh/rc

if [ "$(whoami)" = "vagrant" ]; then
    sudo ln -sf $THIS_DIR/.bashrc /root/.bash_aliases
fi
