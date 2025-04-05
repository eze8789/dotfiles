# .bashrc - Cross-platform for Linux and macOS

# Source global definitions (Linux)
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export GOBIN=$HOME/go/bin
RUST_BIN=$HOME/.cargo/bin
EMACS_BIN=$HOME/.config/emacs/bin

# Homebrew setup - add to the beginning of PATH for precedence
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
NORMAL=$(echo -e "\001\033[00m\002")
GREEN=$(echo -e "\001\033[01;32m\002")
RED=$(echo -e "\001\033[01;31m\002")
BLUE=$(echo -e "\001\033[01;94m\002")
YELLOW=$(echo -e "\001\033[01;33m\002")
PURPLE=$(echo -e "\001\033[01;35m\002")
CYAN=$(echo -e "\001\033[01;36m\002")

# Set default editor
export EDITOR=vim

# Platform-specific commands and aliases
if [[ "$(uname)" == "Darwin" ]]; then  # macOS
    # Use BSD ls flags on macOS
    alias ls='ls -G'
    # macOS already has pbcopy/pbpaste built in - no need for aliases
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
export PS1="\[${GREEN}\]\u@\h \[${YELLOW}\]\w\[\e[91m\]\$(parse_git_branch) \[${YELLOW}\]\$\[\e[00m\] "

# fzf configuration
# First check for user-installed fzf completion/key-binding scripts
if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
# Next try the Homebrew installation locations
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

# pyenv setup (asdf removed as requested)
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv >/dev/null || [ -d "$PYENV_ROOT/bin" ]; then
    [ -d "$PYENV_ROOT/bin" ] && export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv >/dev/null; then
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# Rust environment
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi