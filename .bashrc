system=$(uname -a | awk '{print $1}')

case "$system" in
    Darwin)
	color_flag="-G"
	;;
    Linux)
	color_flag="--color"
	;;
    *)
	color_flag=""
esac

alias ll="ls -hlF $color_flag"
alias l="ll -A"

if [ -e "/Applications/Hex Fiend.app" ]; then
    alias hex='open -a "/Applications/Hex Fiend.app"'
fi

if [ $(which hub) ]; then
    alias git=hub
fi

alias gst='git status'
alias gd='git diff --ignore-space-change'
alias gco='git checkout'
alias gb='git branch'

if [ $(which gitx) ]; then
    alias gx=gitx
    alias gtix=gitx
fi

# aliases for typos with git commands
alias gi='git'
alias gti='git'

alias gita='git' # add
alias gitc='git' # commit
alias gitp='git' # push, pull
alias gitr='git' # rebase

# useful for updating after an accepted pull request; updates local master
# branch and removes local branches whose remotes have been merged into master
function gitprune() {
    git stash
    git checkout master
    git fetch --prune --tags
    git rebase origin/master
    git branch -d $(git branch --merged | grep -v master | awk '{print $1}')
}

function fixup() {
    git commit -m "fixup! $1"
}

alias vn='vagrant nsidc'
alias bvn='bundle exec vagrant nsidc'

if [ $(which bundle) ]; then
    alias be='bundle exec'
    alias ber='bundle exec rake'
fi


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

    cmd="ssh -Y -i $HOME/.ssh/id_rsa_vagrant_vsphere vagrant@$host"

    shift

    echo -e $cmd "$@"
    $cmd "$@"
}

# get vm hostnames
function gethostname() {
    env=$1

    hostname=$(cat .vagrant-$env/machines/default/vsphere-nsidc/nsidc-machine.yaml | grep hostname | awk '{print $2}')

    echo $hostname
}

# vssh to vm based on environment
function vsshe() {
    env=$1
    shift
    hostname=$(gethostname $env)
    vssh "${hostname} ${@}"
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
if [ -d "$COMPLETION" ]; then
    for i in `ls $COMPLETION`; do
	source $COMPLETION/$i
    done
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

case "$(whoami)" in
    vagrant)
	user_host_color="${YELLOW}"
	cwd_color="${RED}"
	prompt_color="${CYAN}"
	git_color="${GREEN}"
	;;
    root)
	user_host_color="${RED}"
	cwd_color="${RED}"
	prompt_color="${RED}"
	git_color="${RED}"
	;;
    *)
	user_host_color="${CYAN}"
	cwd_color="${YELLOW}"
	prompt_color="${RED}"
	git_color="${GREEN}"
esac
user_host="${user_host_color}\u@\h ${CLR_END}"
cwd="${cwd_color}\w${CLR_END}"
prompt="\n  ${prompt_color}>${CLR_END} "
git_prompt="${git_color}${GIT_BRANCH}${CLR_END}"

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
  PROMPT_COMMAND="timer_stop"
else
  PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi

export PS1="\n[\$?] \${timer_show}s \t ${user_host}${cwd}${git_prompt}${prompt}"

export NODE_PATH=~/.npm

alias run='npm run --silent'

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

if [ $(which tree) ]; then
    alias t='tree -a'
fi

# conda for python packaging/env
export PATH="$PATH:$HOME/anaconda3/bin"

(which thefuck > /dev/null) && eval "$(thefuck --alias)"

export NVM_DIR=/Users/$(whoami)/.nvm

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export JSBIN_CONFIG=~/.jsbin/config.local.json
