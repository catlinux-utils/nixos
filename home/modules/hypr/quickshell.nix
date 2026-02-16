{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    home.packages = [
      pkgs.btop
    ];

    programs.quickshell = {
      enable = true;
      configs.default = ../../../config/quickshell;
      activeConfig = "default";
      systemd.enable = true;
    };
  };
}
