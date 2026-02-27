{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;
{
  home.packages = with pkgs; [
    ncdu
    duf
  ];
}
