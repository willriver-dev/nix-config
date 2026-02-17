{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    gh
    git-lfs
    delta
  ];
}
