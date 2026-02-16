{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
      update_ms = 2000;
      rounded_corners = true;
    };
  };
}
