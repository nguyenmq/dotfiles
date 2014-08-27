# .bashrc

set -o vi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# source stuff not tracked by git
if [ -f ~/.customrc ]; then
    source ~/.customrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#export PROMPT_COMMAND="printf \"\\033k[%s]\\033\\\\\" \`basename \${PWD}\`"
export PROMPT_COMMAND=""

# User specific aliases and functions
alias gits="git status"
alias c="clear"
alias ll="ls -al"
