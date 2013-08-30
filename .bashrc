alias l='ls -FlAG $@'
alias ll='ls -FlG $@'

alias gst='git status'
alias gd='git diff'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gpr='git pull --rebase'
alias gx='gitx'
alias gb='git branch'
alias gr='git rebase'
alias gri='git rebase -i'
alias ga='git add'

alias emacsclient=ec

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export GROOVY_HOME=/usr/local/Cellar/groovy/1.8.2/libexec
export GRAILS_HOME=~/local/grails-2.1.3

export PATH="~/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:/Users/michael/local:$PATH"

export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

export PATH=$PATH:/usr/local/share/npm/bin/
export PATH=$PATH:~/.npm/

export PATH="~/local/git:$PATH"

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

for f in completion/*; do source $f; done
