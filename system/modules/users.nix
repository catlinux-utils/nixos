{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

{
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "gamemode"
    ];
    shell = pkgs.zsh;
    initialHashedPassword = "${vars.initialPassword}";
  };
}
