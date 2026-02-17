{ pkgs, ... }:

{
  # Niri compositor (via niri-flake nixosModule)
  programs.niri.enable = true;

  # SDDM display manager với astronaut theme
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs; [
      sddm-astronaut
      kdePackages.qtmultimedia
    ];
  };

  environment.systemPackages = with pkgs; [
    sddm-astronaut
  ];

  # XDG portals for screen sharing, file dialogs
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  services.dbus.enable = true;
  security.polkit.enable = true;
  security.pam.services.hyprlock = {};
}
