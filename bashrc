# .bashrc - Cross-platform for Linux and macOS

# Source global definitions (Linux)
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export GOBIN=$HOME/go/bin
RUST_BIN=$HOME/.cargo/bin
EMACS_BIN=$HOME/.config/emacs/bin

# Homebrew setup 
if [ -d "/opt/homebrew/bin" ]; then
    # Only add if not already in PATH
    if ! [[ ":$PATH:" == *":/opt/homebrew/bin:"* ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
    fi
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:/var/lib/snapd/snap/bin:$GOBIN:$RUST_BIN:$EMACS_BIN:$HOME/.local/protobuf/bin:$PATH"
fi
export PATH

# Bash colors
#NORMAL=$(echo -e "\001\033[00m\002")
#GREEN=$(echo -e "\001\033[01;32m\002")
#RED=$(echo -e "\001\033[01;31m\002")
#BLUE=$(echo -e "\001\033[01;94m\002")
#YELLOW=$(echo -e "\001\033[01;33m\002")
#PURPLE=$(echo -e "\001\033[01;35m\002")
#CYAN=$(echo -e "\001\033[01;36m\002")
RESET="\[\033[0m\]"
GREEN="\[\033[01;32m\]"
RED="\[\033[01;31m\]"
BLUE="\[\033[01;94m\]"
YELLOW="\[\033[01;33m\]"
PURPLE="\[\033[01;35m\]"
CYAN="\[\033[01;36m\]"

# Set default editor
export EDITOR=vim

# Platform-specific commands and aliases
if [[ "$(uname)" == "Darwin" ]]; then  # macOS
    # Use BSD ls flags on macOS
    alias ls='ls -G'
else  # Linux
    # Use GNU ls flags on Linux
    alias ls='ls --color=auto'
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

# Common aliases for both platforms
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias vim='nvim'
alias vi='vim'
alias less='less -R'
alias k='kubectl'
alias ranger="TERM=xterm-256color ranger"

# Load bash completion system
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    elif [ -f /usr/local/etc/bash_completion ]; then
        . /usr/local/etc/bash_completion
    fi
fi

# Load any additional completions from user directory if it exists
if [ -d ~/.bash_completion.d ]; then
    for file in ~/.bash_completion.d/*; do
        if [ -f "$file" ]; then
            . "$file"
        fi
    done
fi

if ! type _init_completion >/dev/null 2>&1; then
    _init_completion() {
        local exclude= flag outx=
        # shellcheck disable=SC2034
        COMPREPLY=()
        # shellcheck disable=SC2034
        cur="${COMP_WORDS[COMP_CWORD]}"
        # shellcheck disable=SC2034
        prev="${COMP_WORDS[COMP_CWORD-1]}"
        # shellcheck disable=SC2034
        words=("${COMP_WORDS[@]}")
        # shellcheck disable=SC2034
        cword=$COMP_CWORD

        if [[ $1 == -n ]]; then
            exclude=$2
            shift 2
        fi

        if [[ $1 == -F ]]; then
            flag=$2
            shift 2
        fi

        if [[ $1 == -o ]]; then
            outx=$2
            shift 2
        fi
    }
fi

if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
    _get_comp_words_by_ref() {
        local exclude flag n
        while [[ $# -gt 0 ]]; do
            case $1 in
                -n) exclude=$2; shift 2 ;;
                -c) flag=1; shift ;;
                -w) flag=2; shift ;;
                -p) flag=3; shift ;;
                -l) flag=4; shift ;;
                *) n=$1; shift ;;
            esac
        done

        case $flag in
            1) printf -v "$n" %s "$COMP_CWORD" ;;
            2) printf -v "$n" %s "${COMP_WORDS[*]}" ;;
            3) printf -v "$n" %s "$prev" ;;
            4) printf -v "$n" %s "$cur" ;;
        esac
    }
fi

# Define basic completion helper functions
if ! type _known_hosts_real >/dev/null 2>&1; then
    _known_hosts_real() {
        local hosts=()
        if [[ -f ~/.ssh/known_hosts ]]; then
            hosts+=($(awk '{print $1}' ~/.ssh/known_hosts | grep -v '^|' | cut -d ',' -f 1 | sed -e 's/\[//g' -e 's/\]//g' | cut -d ':' -f 1))
        fi
        if [[ -f ~/.ssh/config ]]; then
            hosts+=($(grep -i ^host ~/.ssh/config | awk '{print $2}'))
        fi
        COMPREPLY=($(compgen -W "${hosts[*]}" -- "$cur"))
    }
fi

# Define generic utility functions for completion
if ! type _filedir >/dev/null 2>&1; then
    _filedir() {
        local IFS=$'\n'
        local -a toks
        local reset x tmp

        reset=$(tput sgr0)
        
        # Get current directory content
        if [[ $1 == @(d|D) ]]; then
            # Only directories
            toks=($(compgen -d -- "$cur" 2>/dev/null))
        elif [[ $1 == @(f|F) ]]; then
            # Only files
            toks=($(compgen -f -- "$cur" 2>/dev/null | grep -v /$ 2>/dev/null))
        else
            # Both files and directories
            toks=($(compgen -f -- "$cur" 2>/dev/null))
        fi
        
        COMPREPLY+=("${toks[@]}")
    }
fi

# Completions - check command availability for compatibility
# AWS autocompletion
if command -v aws_completer &>/dev/null; then
    complete -C "$(which aws_completer 2>/dev/null || echo '/usr/local/bin/aws_completer')" aws
fi

# bin completion
if command -v bin &>/dev/null; then
    source <(bin completion bash)
fi

# Terraform autocompletion
if command -v terraform &>/dev/null; then
    complete -C "$(which terraform)" terraform
fi

# kubectl autocompletion
if command -v kubectl &>/dev/null; then
    source <(kubectl completion bash)
    complete -F __start_kubectl k
fi

# yq completion
if command -v yq &>/dev/null; then
    source <(yq shell-completion bash)
fi

# gh cli completion
if command -v gh &>/dev/null; then
    eval "$(gh completion -s bash)"
fi

# minikube autocompletion
if command -v minikube &>/dev/null; then
    eval "$(minikube completion bash)"
fi

# kind completion
if command -v kind &>/dev/null; then
    source <(kind completion bash)
fi

export TF_CLI_CONFIG_FILE=".terraformrc"

# Histcontrol
export HISTFILESIZE=1000000
export HISTSIZE=1000000

# Append each command to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# No duplicates
export HISTCONTROL=ignoredups:erasedups

# Append to the history file instead of overwriting when the shell exists
shopt -s histappend

# Git branch parsing for PS1
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set Prompt - keeping your original
#export PS1="\[${GREEN}\]\u@\h \[${YELLOW}\]\w\[\033[91m\]\$(parse_git_branch) \[${YELLOW}\]\$\[\033[00m\] "
export PS1="${GREEN}\u@\h ${YELLOW}\w${RED}\$(parse_git_branch) ${YELLOW}\$${RESET} "

# fzf configuration
# Check user-installed fzf completion/key-binding scripts
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
# Try Homebrew installation locations
elif [ -d "/opt/homebrew/opt/fzf" ]; then
    # Homebrew fzf installation on macOS (Apple Silicon)
    [ -f /opt/homebrew/opt/fzf/shell/completion.bash ] && source /opt/homebrew/opt/fzf/shell/completion.bash
    [ -f /opt/homebrew/opt/fzf/shell/key-bindings.bash ] && source /opt/homebrew/opt/fzf/shell/key-bindings.bash
elif [ -d "/usr/local/opt/fzf" ]; then
    # Homebrew fzf installation on macOS (Intel)
    [ -f /usr/local/opt/fzf/shell/completion.bash ] && source /usr/local/opt/fzf/shell/completion.bash
    [ -f /usr/local/opt/fzf/shell/key-bindings.bash ] && source /usr/local/opt/fzf/shell/key-bindings.bash
elif [ -d "/home/linuxbrew/.linuxbrew/opt/fzf" ]; then
    # Homebrew fzf installation on Linux
    [ -f /home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.bash ] && source /home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.bash
    [ -f /home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.bash ] && source /home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.bash
fi

# pyenv setup
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv >/dev/null; then
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
        if command -v pyenv-virtualenv-init >/dev/null; then
            eval "$(pyenv virtualenv-init -)"
        fi
    fi
fi

# Rust environment
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
