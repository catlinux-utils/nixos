{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;

        wallpaper = [
          {
            monitor = "";
            path = "${../../../config/wallpaper/arch-windows.png}";
            fit_mode = "cover";
          }
        ];
      };
    };
  };
}
