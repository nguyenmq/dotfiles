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

# Exports
export PS1="\[\e[00;32m\][ \[\e[01;32m\]\u@\h:\[\e[01;35m\]\w\[\e[00;32m\] ]\n$ \[\e[0m\]"
export EDITOR=vim

# man pager color -- escapes for urxvt/xterm
# see termcap manpage for definitions
export GROFF_NO_SGR=1                       # output ANSI color escape sequences in raw form
export LESS_TERMCAP_mb=$'\E[01;31m'         # blinking
export LESS_TERMCAP_md=$'\E[01;32m'         # bold          headings            -> green
export LESS_TERMCAP_so=$'\E[01;30;45m'      # standout      statusbar/search    -> highlight red with white foreground
export LESS_TERMCAP_me=$'\E[0m'             # end all modes like so, us, mb, md and mr
export LESS_TERMCAP_se=$'\E[0m'             # end standout-mode
export LESS_TERMCAP_ue=$'\E[0m'             # end underline

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
alias vmp=vimpc

# Override with any local settings not tracked
if [ -f ~/.customrc ]; then
    source ~/.customrc
fi

