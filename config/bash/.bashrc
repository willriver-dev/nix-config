# Prompt
PS1='\[\e[1;34m\]\w\[\e[0m\] \$ '

# Aliases - modern replacements
alias ll='eza -la --group-directories-first'
alias ls='eza'
alias cat='bat --paging=never'
alias tree='eza --tree'
alias ..='cd ..'
alias ...='cd ../..'

# Nix rebuild (thay hostName tương ứng: wsl, laptop, vm-fusion)
alias rebuild='sudo nixos-rebuild switch --flake ~/workspace/nixos-config#wsl'
alias update='nix flake update --flake ~/workspace/nixos-config'

# Docker
alias dps='docker ps'
alias dco='docker compose'

# History
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoredups:erasedups
