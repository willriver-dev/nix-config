{ pkgs, config, lib, osConfig ? {}, ... }:

let
  isWSL = (osConfig ? wsl) && (osConfig.wsl.enable or false);
  credentialHelper =
    if isWSL
    then "/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe"
    else "${pkgs.gh}/bin/gh auth git-credential";
in
{
  programs.git = {
    enable = true;
    userName = "Your Name";       # TODO: change this
    userEmail = "your@email.com"; # TODO: change this

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.autocrlf = "input";
      credential.helper = credentialHelper;
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = false;
        line-numbers = true;
      };
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      lg = "log --oneline --graph --decorate";
    };
  };

  home.packages = with pkgs; [
    gh
    git-lfs
  ];
}
