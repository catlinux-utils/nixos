{ lib, vars, ... }:
with lib;

{
  config = mkIf (vars.modules.display-manager.gdm.enable or false) {

    services.displayManager.plasma-login-manager = {
      enable = true;
      settings = {
        Greeter = {
          PreselectedSession = "hyprland-uwsm.desktop";
        };
      };
    };
    services.desktopManager.plasma6.enable = true;

  };

}
