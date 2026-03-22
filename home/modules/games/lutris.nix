{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;
{
  programs.lutris = {
    enable = true;
  };
}
