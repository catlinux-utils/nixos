{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {
    services.network-manager-applet = {
      enable = true;
    };
  };
}
