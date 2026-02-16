{ pkgs, lib, enableGui ? false, ... }:

{
  imports = [
    ./shell.nix
    ./editors.nix
    ./dev-tools.nix
    ./git.nix
    ./direnv.nix
  ] ++ lib.optionals enableGui [
    ./gui
  ];

  home = {
    stateVersion = "24.11";

    packages = with pkgs; [
      # search & file tools
      ripgrep
      fd
      fzf
      bat
      eza
      tree
      jq
      yq-go

      # system monitoring
      htop
      btop

      # networking
      curl
      wget

      # archive tools
      unzip
      zip
      gzip

      # misc
      tldr
      man-pages
    ];
  };

  programs.home-manager.enable = true;
}
