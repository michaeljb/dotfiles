#!/bin/bash

rm -rf ~/.vagrant.d/vagrant-nsidc/synced_folders/dev/michaeljb-dotfiles
mkdir -p ~/.vagrant.d/vagrant-nsidc/synced_folders/dev/

git clone https://github.com/michaeljb/dotfiles.git ~/.vagrant.d/vagrant-nsidc/synced_folders/dev/michaeljb-dotfiles

