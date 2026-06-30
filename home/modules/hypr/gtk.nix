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
        package = pkgs.noto-fonts;
        name = "Noto Sans";
        size = 10;
      };
    };
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        gtk-enable-primary-paste = true;
      };
    };
  };
}
