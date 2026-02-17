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

  # Wayland environment cho VM
  environment.sessionVariables = {
    # Wayland backends
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";

    # VM workarounds
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBGL_ALWAYS_SOFTWARE = "1";
  };

  # SSH
  services.openssh.enable = true;

  # Networking
  networking.networkmanager.enable = true;
}
