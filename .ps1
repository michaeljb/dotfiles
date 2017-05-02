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
prompt_char="  ${prompt_color}>${CLR_END} "
git_prompt="${git_color}${GIT_BRANCH}${CLR_END}"

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG

__prompt_newline() {
    PS1+="\n"
}

__prompt_space() {
    PS1+=" "
}

__prompt_command() {
    local EXIT="$?"

    PS1=""

    __prompt_newline

    if [ $EXIT != 0 ]; then
	PS1+="${RED}[${EXIT}]${CLR_END}"
    else
	PS1+="${GREEN}[${EXIT}]${CLR_END}"
    fi

    __prompt_space

    # show how long the last command took to run
    PS1+="${BLUE}\${timer_show}s${CLR_END}"

    __prompt_space

    # YYYY-MM-DD HH:MM:SS
    PS1+="\D{%F %T}"

    __prompt_space

    # filesystem basics
    PS1+="${user_host}${cwd}${git_prompt}"

    __prompt_newline

    # prompt character
    PS1+="${prompt_char}"
}

PROMPT_COMMAND="__prompt_command; timer_stop"
