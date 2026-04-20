{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  programs.bat = {
    enable = true;
  };
}
