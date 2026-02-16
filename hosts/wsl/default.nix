{ ... }:

{
  imports = [
    ../common.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "thangha";
  };

  system.stateVersion = "24.11";
}
