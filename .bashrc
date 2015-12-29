alias l='ls -hlAFG'
alias ll='ls -hlFG'

alias hex='open -a "/Applications/Hex Fiend.app"'

alias git=hub

alias gst='git status'
alias gd='git diff --ignore-space-change'
alias gco='git checkout'
alias gb='git branch'

alias gx='gitx'

# aliases for typos with git commands
alias gi='git'
alias gti='git'

alias gita='git' # add
alias gitc='git' # commit
alias gitp='git' # push, pull
alias gitr='git' # rebase

# useful for updating after an accepted pull request; updates local master
# branch and removes local branches whose remotes have been merged into master
alias gitprune='git stash && git checkout master && git fetch --prune --tags && git rebase origin/master && git branch -d $(git branch --merged | grep -v master)'

function fixup() {
    git commit -m "fixup! $1"
}

alias be='bundle exec'
alias ber='bundle exec rake'

# vagrant development
alias vn='bundle exec vagrant nsidc'

# # vagrant ssh, with x-window forwarding
# alias vssh='ssh -X vagrant@127.0.0.1 -p 2222'

function vssh() {
    host=$1

    # remove protocol
    host=$(echo $host | sed -e 's/^.*:\/\///')

    # remove path to file
    host=$(echo $host | sed -e 's/\/.*$//g')

    # remove port
    host=$(echo $host | sed -e 's/:[0-9]*$//g')

    cmd="ssh -A -i $HOME/.ssh/id_rsa_vagrant_vsphere vagrant@$host"

    shift

    echo -e $cmd "$@"
    $cmd "$@"
}

# quickly get the password for vcenter onto the clipboard
function vcenter() {
    cat ~/.vagrant.d/vagrant-nsidc.yaml | grep password: | head -n 1 | awk '{print $2}' | pbcopy
}

export TERM=xterm-256color

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$HOME/local:$PATH"

export PATH="$PATH:$HOME/local/git-hooks"

export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:$HOME/.npm

export PATH="$PATH:$HOME/projects/git-hooks"

COMPLETION=/usr/local/etc/bash_completion.d/
for i in `ls $COMPLETION`; do
  source $COMPLETION/$i
done

if [ ! -e "~/.git-prompt.sh" ]; then
    curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi
source ~/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true # unstaged (*) and staged (+)
GIT_PS1_SHOWUNTRACKEDFILES=true # untracked files (%)
GIT_PS1_SHOWUPSTREAM="auto" # (<) behind, (>) ahead, (<>) diverged, (=) no difference

GIT_BRANCH="\$(__git_ps1)"

#Prompt and prompt colors
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
# 0 - Normal
# 1 - Bold

BLUE="\[\e[0;34m\]"
CYAN="\[\e[0;36m\]"
GREEN="\[\e[0;32m\]"
PURPLE="\[\e[0;35m\]"
RED="\[\e[0;31m\]"
YELLOW="\[\e[0;33m\]"
CLR_END="\[\e[m\]"

export PS1="\n${CYAN}\u@\h ${CLR_END}${YELLOW}\w${CLR_END}${GREEN}${GIT_BRANCH}${CLR_END}\n  ${RED}>${CLR_END} "

export CXXTEST="$HOME/local/cxxtest-4.3/cxxtest"

export NODE_PATH=~/.npm

export EDITOR="emacsclient -nw"


function vmssh() {
    APP="$1"

    if [ -z "$2" ]; then
        ENVIRONMENT="integration"
    else
        ENVIRONMENT="$2"
    fi

    ssh -X vagrant@$ENVIRONMENT.$APP.apps.int.nsidc.org "$@"
}

# debugging for vagrant-nsidc
export NSIDC_PLUGIN_LOG=debug

alias t='tree -a'
