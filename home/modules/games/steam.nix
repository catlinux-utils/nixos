{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;
{
  home.packages = with pkgs; [
    protonup-qt
    gamemode
  ];
}
