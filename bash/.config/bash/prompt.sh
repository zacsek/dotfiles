MAGENTA="\[\033[1;31m\]"
ORANGE="\[\033[1;33m\]"
PURPLE="\[\033[1;35m\]"
WHITE="\[\033[1;37m\]"
RESET="\[\033[m\]"
GRAY="\[\033[0;37m\]"
LRED="\[\033[1;31m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
BOLD="\[\033[1m\]"
ATTR_OFF="\[\033[0m\]"

ps_time="${GRAY}[${LRED}\t${GRAY}] "

if [[ -n $SSH_CLIENT ]]; then
	ps_userhost="${ORANGE}\u@\h${GRAY} "
else
	ps_userhost=""
fi

ps_workdir="${GREEN}\w${GRAY}"

ps_git="${BLUE}\$(__git_ps1) "

if [[ "$EUID" -ne 0 ]]; then
    ps_prompt="${GREEN}${BOLD}\$${ATTR_OFF} "
else
    ps_prompt="${LRED}${BOLD}#${ATTR_OFF} "
fi

PS1="${ps_time}${ps_userhost}${ps_workdir}${ps_git}${ps_prompt}${RESET}"
