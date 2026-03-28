{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "daily";
    clean.extraArgs = "--keep 4 --keep-since 3d";
    flake = vars.flakeLocation + "#" + vars.conf-name;
  };
  home.packages = with pkgs; [
    nix-tree
    nix-prefetch-git
    nix-prefetch-github

  ];
}
