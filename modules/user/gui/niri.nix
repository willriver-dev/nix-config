{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Bar & launcher
    waybar
    fuzzel
    swaybg

    # Screenshot
    grim
    slurp
    wl-clipboard

    # Lock/idle
    hyprlock
    hypridle

    # Notifications
    libnotify
  ];

  # Mako notification daemon
  services.mako = {
    enable = true;
    settings.default-timeout = 5000;
  };
}
