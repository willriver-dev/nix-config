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

  # GPU/Graphics - bắt buộc cho Wayland compositor (niri)
  hardware.graphics.enable = true;
  boot.initrd.kernelModules = [ "virtio_gpu" "vmwgfx" ];

  # Env cho niri chạy trong VM
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Networking
  networking.networkmanager.enable = true;
}
