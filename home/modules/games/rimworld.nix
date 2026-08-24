{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;
{
  config = mkIf (vars.modules.gaming.enable or false) {
    home.packages = with pkgs; [
      rimsort
    ];
  };
}
