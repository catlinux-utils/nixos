{
  lib,
  pkgs,
  vars,
  inputs,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {
    imports = [
      inputs.qtengine.nixosModules.default
    ];

    home.packages = with pkgs; [
      breeze
      breeze.qt5 # Needed if you want Qt5 support.
      breeze-icons
    ];

    programs.qtengine = {
      enable = true;
      config = {
        theme = {
          colorScheme = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
          iconTheme = "breeze-dark";
          style = "breeze";

          font = {
            family = "Cantarell";
            size = 10;
            weight = -1;
          };

          fontFixed = {
            family = "MesloLGL Nerd Font Mono";
            size = 10;
            weight = -1;
          };
        };
      };
    };
  };
}
