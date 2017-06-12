# Steps before running this:
# - set up VirtualBox guest additions
# - set up bridged network in Virtualbox settings
# - set up github ssh keys

sudo add-apt-repository ppa:ubuntu-elisp/ppa
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y emacs-snapshot git tmux openssh-server

# clone the basics
git clone git@github.com:michaeljb/dotfiles.git ~/dotfiles
git clone git@github.com:michaeljb/.emacs.d.git ~/.emacs.d

# setup dotfiles
~/dotfiles/all.sh

# need to install docker
