# just needed on first run
sudo apt-get install -y libc-dev gcc make autoconf automake libncurses-dev gnutls-dev git texinfo
git clone https://git.savannah.gnu.org/git/emacs.git

# update or install
cd emacs/
git pull
./autogen.sh && ./configure && sudo make && sudo make install
