{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    shellAliases = {
      l = "ll";
    };
  };
}
