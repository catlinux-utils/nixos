{
  pkgs,
  lib,
  vars,
  ...
}:
with lib;

{
  config = mkIf (vars.modules.virtualisation.enable or false) {
    environment.systemPackages = with pkgs; [
      docker-compose
    ];

    virtualisation = {
      containers.enable = true;
      docker = {
        enable = true;
        autoPrune.enable = true;
      };
    };

  };

}
