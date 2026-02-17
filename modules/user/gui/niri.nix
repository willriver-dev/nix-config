{ pkgs, noctalia, ... }:

{
  home.packages = [
    # Noctalia shell (thay waybar, fuzzel, swaybg)
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.quickshell

    # Screenshot
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard

    # Lock/idle
    pkgs.hyprlock
    pkgs.hypridle

    # Notifications
    pkgs.libnotify
  ];

  # Mako vẫn dùng Nix config
  services.mako = {
    enable = true;
    settings.default-timeout = 5000;
  };
}
