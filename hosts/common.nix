{ config, pkgs, lib, hostName, enableGui, noctalia ? null, ... }:

let
  username = "thangha";
in
{
  imports = [
    ../modules/system/docker.nix
    ../modules/system/nix-settings.nix
  ];

  networking.hostName = hostName;

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
  ];

  programs.ssh.startAgent = true;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.bash;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = { inherit enableGui hostName noctalia; };
    users.${username} = import ../modules/user;
  };
}
