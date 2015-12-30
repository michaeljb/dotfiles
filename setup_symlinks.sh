#!/bin/bash

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for fn in .bashrc .bash_profile .sizeup.slate .slate .slate.js .gitconfig .tmux.conf; do
    echo "linking $fn in $HOME"
    rm -f $HOME/$fn
    ln -sf $THIS_DIR/$fn $HOME/$fn
done

echo "linking .gitignore_global in $HOME/.gitignore"
rm -f $HOME/.gitignore
ln -sf $THIS_DIR/.gitignore_global $HOME/.gitignore

if [ "$(whoami)" = "vagrant" ]; then
    ln -sf $THIS_DIR/.bashrc /root/.bash_aliases
fi
