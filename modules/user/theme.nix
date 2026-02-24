{ ... }:

{
  catppuccin = {
    enable = true;
    flavor = "latte";
    accent = "blue";
    cursors.enable = true;
  };

  # CLI tools được theme bởi catppuccin khi dùng programs.* thay vì home.packages
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.fzf.enable = true;
  programs.eza.enable = true;

  # GTK theme (áp dụng cho toàn bộ GTK apps)
  gtk.enable = true;
}

