{ lib, vars, ... }:
with lib;

{
  config = mkIf (vars.modules.vm.enable or false) {
    services.qemuGuest = {
      enable = true;
    };

  };

}
