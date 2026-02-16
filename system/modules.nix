{
  inputs,
  lib,
  vars,
  ...
}:
with lib;

{
  imports =
    let
      allFiles = lib.filesystem.listFilesRecursive ./modules;
    in
    builtins.filter (file: lib.hasSuffix ".nix" (builtins.baseNameOf file)) allFiles;
  services.desktopManager.plasma6.enable = true; # temp to test

}
