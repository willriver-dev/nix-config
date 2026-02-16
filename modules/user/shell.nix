{ pkgs, hostName ? "wsl", ... }:

let
  flakePath = "~/workspace/nixos-config";
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ll = "eza -la --group-directories-first";
      ls = "eza";
      cat = "bat --paging=never";
      tree = "eza --tree";
      ".." = "cd ..";
      "..." = "cd ../..";

      # Nix shortcuts
      rebuild = "sudo nixos-rebuild switch --flake ${flakePath}#${hostName}";
      update = "nix flake update --flake ${flakePath}";

      # Docker shortcuts
      dps = "docker ps";
      dco = "docker compose";
    };

    bashrcExtra = ''
      # Prompt: directory in blue + $
      PS1='\[\e[1;34m\]\w\[\e[0m\] \$ '
    '';

    historySize = 50000;
    historyFileSize = 50000;
    historyControl = [ "ignoredups" "erasedups" ];
  };
}
