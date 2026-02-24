{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    libnotify
    adw-gtk3
    swappy
  ];

  xdg.configFile."DankMaterialShell/themes/catppuccin.json".text = builtins.toJSON {
    light = {
      name = "Catppuccin Latte";
      primary = "#1e66f5";
      primaryText = "#eff1f5";
      primaryContainer = "#7287fd";
      secondary = "#8839ef";
      surface = "#eff1f5";
      surfaceText = "#4c4f69";
      surfaceVariant = "#ccd0da";
      surfaceVariantText = "#4c4f69";
      surfaceTint = "#1e66f5";
      background = "#e6e9ef";
      backgroundText = "#4c4f69";
      outline = "#9ca0b0";
      surfaceContainer = "#dce0e8";
      surfaceContainerHigh = "#ccd0da";
      surfaceContainerHighest = "#bcc0cc";
      error = "#d20f39";
      warning = "#df8e1d";
      info = "#04a5e5";
      matugen_type = "scheme-tonal-spot";
    };
    dark = {
      name = "Catppuccin Mocha";
      primary = "#89b4fa";
      primaryText = "#1e1e2e";
      primaryContainer = "#b4befe";
      secondary = "#cba6f7";
      surface = "#1e1e2e";
      surfaceText = "#cdd6f4";
      surfaceVariant = "#313244";
      surfaceVariantText = "#cdd6f4";
      surfaceTint = "#89b4fa";
      background = "#181825";
      backgroundText = "#cdd6f4";
      outline = "#6c7086";
      surfaceContainer = "#11111b";
      surfaceContainerHigh = "#313244";
      surfaceContainerHighest = "#45475a";
      error = "#f38ba8";
      warning = "#f9e2af";
      info = "#89dceb";
      matugen_type = "scheme-tonal-spot";
    };
  };

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      currentThemeName = "custom";
      customThemeFile = "${config.home.homeDirectory}/.config/DankMaterialShell/themes/catppuccin.json";
    };
  };
}
