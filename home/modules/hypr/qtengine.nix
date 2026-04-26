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

    home.packages = with pkgs; [
      kdePackages.breeze
      kdePackages.breeze.qt5 # Needed if you want Qt5 support.
      kdePackages.breeze-icons
      qtengine
    ];

    # Configure qtengine via xdg.configFile (home-manager equivalent)
    xdg.configFile."qtengine/config.json" = {
      text = builtins.toJSON {
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

    # Set environment variable for qtengine
    home.sessionVariables.QT_QPA_PLATFORMTHEME = "qtengine";
    home.sessionVariables.QT_ICON_THEME = "breeze-dark";
    systemd.user.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qtengine";
      QT_ICON_THEME = "breeze-dark";
    };

  };
}
