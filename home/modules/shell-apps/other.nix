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
    unzip
    p7zip
  ];
}
