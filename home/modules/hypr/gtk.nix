{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    gtk = {
      enable = true;
      colorScheme = "dark";

      theme = {
        package = pkgs.materia-theme;
        name = "Materia-dark-compact";
      };

      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
        size = 10;
      };
    };
  };
}
