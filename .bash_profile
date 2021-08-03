# From http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html:
# Say, you’d like to print some lengthy diagnostic information about your machine each time you login (load average, memory usage, current users, etc). You only want to see it on login, so you only want to place this in your .bash_profile. If you put it in your .bashrc, you’d see it every time you open a new terminal window.

if [ -f ~/.profile ]; then
   source ~/.profile
fi

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

. /Users/mbrandt/anaconda3/etc/profile.d/conda.sh

# Created by `userpath` on 2020-03-26 21:33:23
export PATH="$PATH:/Users/mbrandt/.local/bin"

# Python - pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


export PATH="$HOME/.poetry/bin:$PATH"
