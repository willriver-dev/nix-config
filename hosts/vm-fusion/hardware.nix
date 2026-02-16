# PLACEHOLDER - Replace with output of:
#   sudo nixos-generate-config --show-hardware-config
# Run this inside the VMware Fusion VM.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "uhci_hcd" "ahci" "xhci_pci" "nvme" "usbhid" "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # MUST replace with actual UUIDs from nixos-generate-config
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/PLACEHOLDER-ROOT-UUID";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/PLACEHOLDER-BOOT-UUID";
    fsType = "vfat";
  };

  swapDevices = [ ];
}
