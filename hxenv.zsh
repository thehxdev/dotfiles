#!/usr/bin/env bash

export __HX_OPT_PATH="$HOME/opt"
export __HX_OPT_GLOBAL_PATH="$__HX_OPT_PATH/_global"
export GOPROXY='https://goproxy.io,direct'

__PATH=""
for p in $(ls -1 $__HX_OPT_GLOBAL_PATH); do
    __absolute_path="$__HX_OPT_GLOBAL_PATH/$p/bin"
    if [[ ! "$PATH" == *"$__absolute_path"* ]]; then
        __PATH+="$__absolute_path:"
    fi
done

__other_paths=( "$HOME/.local/bin" "$HOME/go/bin" )
for p in "${__other_paths[@]}"; do
    if [[ ! "$PATH" == *"$p"* ]]; then
        __PATH+="$p:"
    fi
done
export PATH="$PATH:$__PATH"

export EDITOR='nvim'
export MANPAGER="nvim +Man!"

alias nv='nvim'
alias tm='tmux'
alias ll='eza -lh --group-directories-first'
alias la='eza -lha --group-directories-first'
alias cdo='cd ~/opt'
alias ip='ip -c=auto'
alias gitc='git clone --shallow-submodules --remote-submodules --recursive'

# Yazi file manager
# function y() {
#     local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
#     yazi "$@" --cwd-file="$tmp"
#     IFS= read -r -d '' cwd < "$tmp"
#     [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
#     rm -f -- "$tmp"
# }

# FZF
__FZF_WALKER_SKIP=".git,.var,.cargo,node_modules,target,build,vcpkg"
export FZF_DEFAULT_OPTS='--tmux 70% --layout reverse'
export FZF_CTRL_T_OPTS="
    --walker-skip ${__FZF_WALKER_SKIP}
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="
  --walker-skip ${__FZF_WALKER_SKIP}
  --preview 'eza -T -L 1 {}'"
