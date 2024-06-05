# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export GOBIN=$HOME/go/bin
RUST_BIN=$HOME/.cargo/bin
EMACS_BIN=$HOME/.config/emacs/bin

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:/var/lib/snapd/snap/bin:$GOBIN:$RUST_BIN:$EMACS_BIN:$HOME/.local/protobuf/bin:$PATH"
fi
export PATH

# Bash colors
NORMAL=$(echo -e "\001\033[00m\002")
GREEN=$(echo -e "\001\033[01;32m\002")
RED=$(echo -e "\001\033[01;31m\002")
BLUE=$(echo -e "\001\033[01;94m\002")
YELLOW=$(echo -e "\001\033[01;33m\002")
PURPLE=$(echo -e "\001\033[01;35m\002")
CYAN=$(echo -e "\001\033[01;36m\002")

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
alias ls='ls --color=auto'
alias vim='nvim'
alias ranger="TERM=xterm-256color ranger"

#AWS autocompletion
complete -C '/usr/local/bin/aws_completer' aws

# bin completion
source <(bin completion bash)

# Terraform autocompletion
complete -C /home/linuxin/.asdf/shims/terraform terraform

# kubectl autocompletion
source <(kubectl completion bash)

# yq completion
source <(yq shell-completion bash)

# gh cli completion
eval "$(gh completion -s bash)"

# minikube autocompletion
if command -v minikube &>/dev/null; then
	eval "$(minikube completion bash)"
fi

export TF_CLI_CONFIG_FILE=".terraformrc"

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
alias k='kubectl'
complete -F __start_kubectl k

# kind completion
source <(kind completion bash)

parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#export PS1="\[\e\033[01;32m\]\u@\h \[\e\033[01;34m\]\w\[\e[91m\]\$(parse_git_branch) \[\e\033[01;34m\]\$\[\e[00m\] "
export PS1="\[${GREEN}\u@\h \[${YELLOW}\w\[\e[91m\]\$(parse_git_branch) \[${YELLOW}\$\[\e[00m\] "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
. "$HOME/.cargo/env"
