{ pkgs, ... }:

let
  mod = "Mod";
in
{
  programs.niri.settings = {
    input = {
      keyboard.xkb.layout = "us";
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
    };

    layout = {
      gaps = 8;
      border = {
        enable = true;
        width = 2;
      };
      default-column-width = { proportion = 0.5; };
    };

    spawn-at-startup = [
      { command = [ "waybar" ]; }
      { command = [ "swaybg" "-c" "#1e1e2e" ]; }
    ];

    binds = {
      "${mod}+Return".action.spawn = [ "alacritty" ];
      "${mod}+D".action.spawn = [ "fuzzel" ];
      "${mod}+Q".action.close-window = [];
      "${mod}+F".action.maximize-column = [];
      "${mod}+Shift+F".action.fullscreen-window = [];

      # Focus
      "${mod}+H".action.focus-column-left = [];
      "${mod}+L".action.focus-column-right = [];
      "${mod}+J".action.focus-window-down = [];
      "${mod}+K".action.focus-window-up = [];

      # Move windows
      "${mod}+Shift+H".action.move-column-left = [];
      "${mod}+Shift+L".action.move-column-right = [];
      "${mod}+Shift+J".action.move-window-down = [];
      "${mod}+Shift+K".action.move-window-up = [];

      # Workspaces
      "${mod}+1".action.focus-workspace = 1;
      "${mod}+2".action.focus-workspace = 2;
      "${mod}+3".action.focus-workspace = 3;
      "${mod}+4".action.focus-workspace = 4;
      "${mod}+5".action.focus-workspace = 5;

      "${mod}+Shift+1".action.move-column-to-workspace = 1;
      "${mod}+Shift+2".action.move-column-to-workspace = 2;
      "${mod}+Shift+3".action.move-column-to-workspace = 3;
      "${mod}+Shift+4".action.move-column-to-workspace = 4;
      "${mod}+Shift+5".action.move-column-to-workspace = 5;

      # Screenshots
      "Print".action.screenshot = [];
      "${mod}+Print".action.screenshot-screen = [];
    };
  };

  home.packages = with pkgs; [
    fuzzel
    waybar
    swaybg
    swaylock
    swayidle
    grim
    slurp
    wl-clipboard
    mako
    libnotify
  ];

  services.mako = {
    enable = true;
    settings.default-timeout = 5000;
  };
}
