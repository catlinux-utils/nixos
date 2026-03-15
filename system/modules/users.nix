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
      "wideo"
      "render"
      "docker"
    ];
    shell = pkgs.zsh;
    initialHashedPassword = "${vars.initialPassword}";
  };
}
