#!/bin/bash

./setup_symlinks.sh
./bootstrap_emacs.sh
./setup_vagrant_synced_folder.sh

echo -e "RUN THIS:\ncd && source ~/.bashrc"
