{ pkgs, ... }:

{
  home.packages = [ pkgs.chromium ];

  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      settings = {
        "browser.contentblocking.category" = "strict";
        "privacy.trackingprotection.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.urlbar.suggest.searches" = true;
        "gfx.webrender.all" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };
}
