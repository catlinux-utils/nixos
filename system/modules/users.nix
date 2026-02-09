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
    ];
    shell = pkgs.zsh;
    initialHashedPassword = "${vars.initialPassword}";
  };
}
