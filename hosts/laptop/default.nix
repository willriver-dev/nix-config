{ config, pkgs, lib, ... }:

let
  username = "thangha";
in
{
  imports = [
    ../common.nix
    ./hardware.nix
    ../../modules/system/gui
  ];

  system.stateVersion = "24.11";

  # Bootloader - systemd-boot (NixOS only, no dual boot)
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking.networkmanager.enable = true;
  users.users.${username}.extraGroups = [ "networkmanager" ];

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # AMD GPU (RDNA integrated)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # AMD CPU microcode
  hardware.cpu.amd.updateMicrocode = true;

  # Firmware updates
  services.fwupd.enable = true;

  # Power management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Backlight control
  programs.light.enable = true;

  # Printing
  services.printing.enable = true;
}
