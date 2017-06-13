# Steps before running this:
# - set up VirtualBox guest additions
# - set up bridged network in Virtualbox settings
# - set up github ssh keys

sudo add-apt-repository ppa:ubuntu-elisp/ppa
sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y \
    emacs-snapshot git tmux openssh-server \  # basic dev tools
    apt-transport-https ca-certificates curl software-properties-common  # docker reqs


# clone the basics
git clone git@github.com:michaeljb/dotfiles.git ~/dotfiles
git clone git@github.com:michaeljb/.emacs.d.git ~/.emacs.d

# setup dotfiles
~/dotfiles/all.sh

# need to install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

if [[ "$(sudo apt-key fingerprint 0EBFCD88 | grep Key)" != *"9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88"* ]]; then
    echo "Docker key fingerprint does not match official fingerprint."
    echo
    "https://docs.docker.com/engine/installation/linux/ubuntu/#install-using-the-repository"
    exit 1
fi

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update

sudo apt-get install -y docker-ce

sudo sh -c "curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-$(uname -s)-$(uname -m) > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose

sudo groupadd docker
sudo usermod -aG docker ${USER}

echo "log out and log back in for the group changes to take effect"
