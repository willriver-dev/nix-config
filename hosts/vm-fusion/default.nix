{ config, pkgs, lib, ... }:

{
  imports = [
    ../common.nix
    ./hardware.nix
    ../../modules/system/gui
  ];

  system.stateVersion = "24.11";

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # VMware Fusion guest tools
  virtualisation.vmware.guest.enable = true;

  # Networking
  networking.networkmanager.enable = true;
}
