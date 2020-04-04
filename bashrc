# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Set default editor
export EDITOR=vim

# colors for all grep commands
# TODO Change GREP_OPTIONS since it's deprecated
#export GREP_OPTIONS='--color=auto'

alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

#AWS autocompletion
complete -C '/usr/local/bin/aws_completer' aws

# Terraform autocompletion
complete -C /usr/local/bin/terraform terraform

# kubectl autocompletion
source <(kubectl completion bash)

# minikube autocompletion
if command -v minikube &>/dev/null
then
	  eval "$(minikube completion bash)"
fi

# Histcontrol
export HISTFILESIZE=1000000
export HISTSIZE=1000000

# Append each command to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMANDS"\n"}history -a; history -c; history -r"

# No duplicates
export HISTCONTROL=ignoredups:erasedups

# Append to the history file instead of overwriting when the shell exists
shopt -s histappend

alias vi='vim'
alias less='less -R'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

