{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    home.packages = with pkgs; [
      blueman
    ];
    services.blueman-applet = {
      enable = true;
    };
  };
}
