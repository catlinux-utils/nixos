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
      # docker = {
      #   enable = true;
      #   autoPrune.enable = true;
      # };
      podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
      };
    };

    environment.sessionVariables = {
      PODMAN_COMPOSE_WARNING_LOGS = "false";
    };
  };
}
