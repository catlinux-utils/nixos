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
      kdePackages.breeze.qt5
      kdePackages.breeze-icons
      qtengine
    ];

    xdg.configFile."qtengine/config.json" = {
      text = builtins.toJSON {
        theme = {
          colorScheme = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
          iconTheme = "breeze-dark";
          style = "breeze";

          font = {
            family = "Noto Sans";
            size = 10;
            weight = -1;
          };

          fontFixed = {
            family = "MesloLGS Nerd Font Mono";
            size = 10;
            weight = -1;
          };
        };
      };
    };

    # Set environment variables for regular shell sessions
    home.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qtengine";
      QT_ICON_THEME = "breeze-dark";
      # Use lib.mkForce to resolve the conflict and include both required paths
      XDG_DATA_DIRS = lib.mkForce "${pkgs.kdePackages.breeze-icons}/share:${pkgs.networkmanagerapplet}/share:$XDG_DATA_DIRS";
    };

    # Set environment variables specifically for the systemd user session
    systemd.user.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qtengine";
      QT_ICON_THEME = "breeze-dark";
      # Use lib.mkForce here as well to ensure the systemd service gets the combined paths
      XDG_DATA_DIRS = lib.mkForce "${pkgs.kdePackages.breeze-icons}/share:${pkgs.networkmanagerapplet}/share:$XDG_DATA_DIRS";
    };

  };
}
