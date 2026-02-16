{ lib, vars, ... }:

{

  home.username = "${vars.user}";
  home.homeDirectory = "/home/${vars.user}";

  fonts.fontconfig.enable = true;

  imports =
    let
      allFiles = lib.filesystem.listFilesRecursive ./modules;
    in
    builtins.filter (file: lib.hasSuffix ".nix" (builtins.baseNameOf file)) allFiles;

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
