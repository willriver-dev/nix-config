{ pkgs, ... }:

{
  # Niri compositor (via niri-flake nixosModule)
  programs.niri.enable = true;

  # SDDM display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # XDG portals for screen sharing, file dialogs
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  services.dbus.enable = true;
  security.polkit.enable = true;
}
