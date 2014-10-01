# .bashrc

set -o vi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#export PROMPT_COMMAND="printf \"\\033k[%s]\\033\\\\\" \`basename \${PWD}\`"
export PROMPT_COMMAND=""

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

color_prompt=yes

export PS1="\[\e[00;32m\][ \[\e[0m\]\[\e[01;32m\]\W\[\e[0m\]\[\e[00;32m\] ]\[\e[0m\] "

# don't expand the tilde
_expand()
{
    return 0;
}

# User specific aliases and functions
alias gits="git status"
alias c="clear"
alias ls="ls --color=auto"
alias ll="ls -al"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias vi="vim"

# Override with any local settings not tracked
if [ -f ~/.customrc ]; then
    source ~/.customrc
fi

