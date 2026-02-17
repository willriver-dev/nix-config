{ pkgs, hostName, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      ll = "eza -la --icons";
      ls = "eza --icons";
      la = "eza -a --icons";
      lt = "eza --tree --icons --level=2";

      # Git
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      glog = "git log --oneline --graph --decorate";

      # System
      cat = "bat";
      top = "btop";
      grep = "grep --color=auto";

      # NixOS rebuild per host
      rebuild = "sudo nixos-rebuild switch --flake ~/nix-config#${hostName}";
      rebuild-boot = "sudo nixos-rebuild boot --flake ~/nix-config#${hostName}";
      rebuild-test = "sudo nixos-rebuild test --flake ~/nix-config#${hostName}";
      nix-clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      nix-update = "cd ~/nix-config && nix flake update";
    };

    initExtra = ''
      # Source file local (tự do thêm config mà không cần rebuild)
      [ -f ~/.bashrc.local ] && source ~/.bashrc.local

      # Prompt
      PS1='\[\e[1;34m\]\w\[\e[0m\] $ '

      # History
      export HISTSIZE=10000
      export HISTFILESIZE=20000
      export HISTCONTROL=ignoreboth:erasedups
      shopt -s histappend

      # Auto-cd
      shopt -s autocd

      # PATH
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };
}
