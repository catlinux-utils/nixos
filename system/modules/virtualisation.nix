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
      podman-compose
      podman-tui

    ];

    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };

  };

}
