alias l='ls -FlAG $@'
alias ll='ls -FlG $@'

alias emacs='open -a /Applications/Emacs.app'
export VISUAL=/Applications/Emacs.app/Contents/MacOS/Emacs;
export EDITOR=/Applications/Emacs.app/Contents/MacOS/Emacs;

alias indigo='open -a /Applications/Eclipse/Indigo/Eclipse.app'
alias juno='open -a /Applications/Eclipse/Juno/Eclipse.app'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export GROOVY_HOME=/usr/local/Cellar/groovy/1.8.2/libexec
export GRAILS_HOME=~/local/grails-2.1.3

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:/Users/michael/local:$PATH"

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH=$PATH:/usr/local/share/npm/bin/

export PATH="~/local/git:$PATH"

source ~/.git-completion.bash


source ~/.git-prompt.sh
GIT_BRANCH="\$(__git_ps1)"

RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[1;33m\]"
CLR_END="\[\e[m\]"

MAIN_CLR="${YELLOW}"
BRANCH_CLR="${GREEN}"

export PS1="${MAIN_CLR}\u:\W${CLR_END}${BRANCH_CLR}${GIT_BRANCH}${CLR_END} ${MAIN_CLR}\$${CLR_END} "
