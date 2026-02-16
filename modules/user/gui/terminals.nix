{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 12.0;
      };
      window = {
        padding = { x = 8; y = 8; };
        opacity = 0.95;
      };
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      window_padding_width = 8;
      background_opacity = "0.95";
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
    };
  };

  home.packages = with pkgs; [
    ghostty
  ];

  xdg.configFile."ghostty/config".text = ''
    font-family = JetBrainsMono Nerd Font
    font-size = 12
    window-padding-x = 8
    window-padding-y = 8
    background-opacity = 0.95
  '';
}
