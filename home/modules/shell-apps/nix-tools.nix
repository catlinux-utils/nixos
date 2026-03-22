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
    clean.dates = "weekly";
    clean.extraArgs = "--keep 5 --keep-since 3d";
    flake = vars.flakeLocation + "#" + vars.conf-name;
  };
  home.packages = with pkgs; [
    nix-tree
    nix-prefetch-git
    nix-prefetch-github

  ];
}
