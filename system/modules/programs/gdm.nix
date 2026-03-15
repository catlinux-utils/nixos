{ lib, vars, ... }:
with lib;

{
  config = mkIf (vars.modules.display-manager.gdm.enable or false) {

    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };

  };

}
