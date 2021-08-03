system=$(uname -a | awk '{print $1}')

case "$system" in
    Darwin)
	color_flag="-G"
	;;
    Linux)
	color_flag="--color=always"
	;;
    *)
	color_flag=""
esac



###################
# ls modification #
###################

LS_FLAGS="-hlF $color_flag"

unset CLICOLOR
# export CLICOLOR=true
# export CLICOLOR_FORCE=true

function ll {
    ls ${LS_FLAGS} $@ # | grep -v .DS_Store
}

# -a - show all files
# -A - show 'almost all' files - show .files except . and ..
alias l="ll ${LS_FLAGS} -A"
alias lt="ll ${LS_FLAGS} -A -tr"

#######
# end #
#######



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

# useful for updating after an accepted pull request; updates local master
# branch and removes local branches whose remotes have been merged into master
function gitprune() {
    git stash
    git checkout master
    git fetch --prune --tags
    git rebase origin/master
    git branch -d $(git branch --merged | grep -v master | awk '{print $1}')
}

alias vn='vagrant nsidc'
alias bvn='bundle exec vagrant nsidc'
alias bv='bundle exec vagrant'

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

    cmd="ssh -Y -i $HOME/.ssh/id_rsa_vagrant_vsphere vagrant@$host -A"

    shift

    echo -e ssh -Y -i $HOME/.ssh/id_rsa_vagrant_vsphere vagrant@$host -A "$@"
    ssh -Y -i $HOME/.ssh/id_rsa_vagrant_vsphere vagrant@$host -A "$@"
}

function getvmname() {
    env=$1

    vmname="${env}"

    if [ "${env}" = "dev" ]; then
        vmname="${vmname}-${USER}"
    fi

    echo $vmname
}

# get vm hostnames
function gethostname() {
    env=$1

    vmname=$(getvmname $env)

    hostname=$(cat .vagrant/machines/${vmname}/vsphere-nsidc/nsidc-machine.yaml | grep hostname | awk '{print $2}')

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

# export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/sbin:$HOME/local:$PATH"

export PATH="$PATH:$HOME/local/git-hooks"

export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:$HOME/.npm

export PATH="$PATH:$HOME/projects/git-hooks"

COMPLETION=/usr/local/etc/bash_completion.d
if [ -d "$COMPLETION" ]; then
    for i in `ls $COMPLETION`; do
	source $COMPLETION/$i
    done
fi

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

# courtesy Daniel Crumly
function vmlookup {
    if [ $# -lt 2 ]; then
        echo "vmlookup IP zone";
        return 1;
    fi;

    echo "$1" | grep $1;

    hostname=`vagrant nsidc dns print-records A --zone $2.int.nsidc.org | grep -B 3 $1 | head -1 | awk '{print $2}'`;
    if [ "$hostname" = "" ]; then
        echo "IP address $1 not found.";
        return 1;
    fi;

    echo " host: $hostname" | grep host;
    vagrant nsidc dns print-records CNAME --zone $2.int.nsidc.org | grep -B 3 $hostname | grep fqdn;
    vagrant nsidc dns print-records TXT --zone $2.int.nsidc.org | grep -A 5 $hostname | grep txtdata;
}

# debugging for vagrant-nsidc
export NSIDC_PLUGIN_LOG=debug

if [ $(which tree) ]; then
    alias t='tree -a'
fi

# conda for python packaging/env
export PATH="$PATH:$HOME/anaconda3/bin"


# NVM
export NVM_DIR=${HOME}/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
## NVM (experimental) - from jkovarik
export NVM_DIR="$HOME/.nvm"
. "${NVM_DIR}/nvm.sh"
npm_new_directory() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi
  PREV_PWD=$PWD
  [[ -f ".nvmrc" ]] && nvm use
}


export JSBIN_CONFIG=~/.jsbin/config.local.json

# added by travis gem
[ -f /Users/mbrandt/.travis/travis.sh ] && source /Users/mbrandt/.travis/travis.sh

source ~/.ps1

# stop having weird characters like "00~" show up when pasting into iterm
# https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/issues/31#issuecomment-55966569
# printf '\e[?2004l'

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

# sudo add-apt-repository -y ppa:kelleyk/emacs && sudo apt-get update && sudo apt-get install -y emacs25 && emacs -nw .

# https://askubuntu.com/questions/969053/map-caps-lock-to-control-on-ubuntu-17-10
# change caps lock to control in ubuntu 18
# setxkbmap -option ctrl:nocaps

function dockernuke() {
    docker stop $(docker ps --all --quiet)
    docker system prune --all --force
}

# generic help--open man page if available, or add --version and pipe to less
# to "simulate" a man page
function m() {
    man $1 || ($1 --help | less)
}

# source ./ssh-ecs.sh
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

AWS_SDK_LOAD_CONFIG=1
# AWS_PROFILE=sandbox  # for now, sandbox is default in ~/.aws/credentials
AWS_REGION=us-west-2
export  AWS_SDK_LOAD_CONFIG
# export AWS_PROFILE
export AWS_REGION

alias tf=terraform
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

awsjqevent() {
    TMP_DIR=/tmp/awsevents
    mkdir -p ${TMP_DIR}

    event_log=${TMP_DIR}/$1.json

    # download event log from AWS, unless we previously downloaded it
    if [ ! -f ${event_log} ]; then
        aws s3 cp s3://nsidc-cumulus-dev-internal/events/$1 ${event_log} > /dev/null 2>&1
    fi

    # if it's an event we downloaded a while ago, update the date so it doesn't
    # get cleaned up
    touch ${event_log}

    # feed the event to jq for nice formatting/accessing only certain keys, etc.
    cat ${event_log} | jq #"$2"

    # clean up any events more than a week old to keep the size of /tmp under control
    find ${TMP_DIR} -type f -mtime +7 | xargs rm -fv
}

# rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
