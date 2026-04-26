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
      nemo-with-extensions
      adwaita-icon-theme
    ];

    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 16;
    };
  };
}
