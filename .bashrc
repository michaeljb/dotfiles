alias l='ls -FlAG $@'
alias ll='ls -FlG $@'

alias gst='git status'
alias gd='git diff'
alias gco='git checkout'
alias gpr='git pull --rebase'
alias gx='gitx'
alias gb='git branch'
alias gr='git rebase'
alias gri='git rebase -i'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$HOME/local:$PATH"

export PATH="$PATH:$HOME/local/git-hooks"

export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:$HOME/.npm

export PATH="$HOME/projects/git-hooks:$PATH"

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

export PS1="${CYAN}\u@\h${CLR_END} ${YELLOW}\w${CLR_END}${GREEN}${GIT_BRANCH}${CLR_END} ${PURPLE}\$${CLR_END} "

# bash completion installed by homebrew
source /usr/local/etc/bash_completion.d

export CXXTEST="$HOME/local/cxxtest-4.3/cxxtest"

export NODE_PATH=~/.npm

export EDITOR="emacsclient -nw"
