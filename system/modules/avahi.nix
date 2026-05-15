{ pkgs, lib, vars, ... }:
with lib;
{
  config = mkIf (vars.modules.avahi.enable or false) {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
  };
}
