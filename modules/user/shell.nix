{ ... }:

{
  # Giữ minimal để direnv bash integration hoạt động
  programs.bash = {
    enable = true;
    enableCompletion = true;

    # Source file local để thêm config tự do mà không cần rebuild
    initExtra = ''
      [ -f ~/.bashrc.local ] && source ~/.bashrc.local
    '';
  };
}
