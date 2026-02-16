{ pkgs, ... }:

{
  # Niri compositor (via niri-flake nixosModule)
  programs.niri.enable = true;

  # Display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
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
  security.pam.services.swaylock = {};
}
