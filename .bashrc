alias l='ls -GAl $@'
alias ll='ls -Gl $@'

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
export PS1="\u:\W \$(__git_ps1)$ "
