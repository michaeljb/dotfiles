#!/bin/bash

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


source ~/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true # unstaged (*) and staged (+)
GIT_PS1_SHOWUNTRACKEDFILES=true # untracked files (%)
GIT_PS1_SHOWUPSTREAM="auto" # (<) behind, (>) ahead, (<>) diverged, (=) no difference


__prompt() {
    local string=$1
    local color=$2

    if [ -z "${color}" ]; then
	PS1+="${string}"
    else
	PS1+="${color}${string}${CLR_END}"
    fi
}

__prompt_command() {
    local EXIT="$?"

    PS1=""

    __prompt "\n"

    if [ $EXIT != 0 ]; then
	EXIT_COLOR="${RED}"
    else
	EXIT_COLOR="${GREEN}"
    fi
    __prompt "[${EXIT}]" "${EXIT_COLOR}"

    __prompt " "

    # show how long the last command took to run
    __prompt "\${timer_show}" "${BLUE}"

    __prompt " "

    # YYYY-MM-DD HH:MM:SS
    __prompt "\D{%F %T}"

    __prompt " "

    # username and host
    __prompt "\u@\h " "${user_host_color}"

    # cwd
    __prompt "\w" "${cwd_color}"

    # GIT
    __prompt "\$(__git_ps1)" "${git_color}"

    __prompt "\n  "

    # conda env normally shows up at beginning of prompt, but must be handled
    # here when setting PROMPT_COMMAND
    if [ ! -z "${CONDA_DEFAULT_ENV}" ]; then
    	__prompt "(${CONDA_DEFAULT_ENV}) " "${PURPLE}"
    fi

    __prompt "> " "${RED}"
}


function timer_result() {
    ((h=${1}/3600))
    ((m=(${1}%3600)/60))
    ((s=${1}%60))

    if [ "${m}" = "0" ] && [ "${h}" = "0" ]; then
	printf "(%02d)" $s
    elif [ "${h}" = "0" ]; then
	printf "(%02d:%02d)" $m $s
    else
	printf "(%02d%:02d:%02d)" $h $m $s
    fi
}

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(timer_result $(($SECONDS - $timer)))
  unset timer
}

trap 'timer_start' DEBUG

PROMPT_COMMAND="__prompt_command; timer_stop"
