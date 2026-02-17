{ ... }:

{
  # Giữ minimal để direnv bash integration hoạt động
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
}
