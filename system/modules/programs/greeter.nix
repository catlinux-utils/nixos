{ lib, vars, ... }:
with lib;

{
  config = mkIf (vars.modules.display-manager.greeter.enable or false) {

    # services.displayManager.plasma-login-manager = {
    #   enable = true;
    # };

    # environment.etc."plasmalogin.conf".text = ''
    #   [Greeter]
    #   PreselectedSession=hyprland-uwsm.desktop
    # '';
    # services.desktopManager.plasma6.enable = true;

    services.displayManager.gdm = {
      enable = true;
    };

  };

}
