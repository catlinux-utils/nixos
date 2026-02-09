{ pkgs }:

rec {
  user = "cat";
  flakeLocation = "/home/${user}/github/nixos";
  networkingHostName = "nixos";
  timezone = "Europe/Warsaw";
  defaultLocale = "pl_PL.UTF-8";
  consoleFont = "Lat2-Terminus16";
  initialPassword = "";
  nixExtraOptions = "experimental-features = nix-command flakes";
  efiSysMountPoint = "/efi";
  grubDevice = "nodev";
  configurationLimit = 10;
  modules = {
    bootloader = {
      grub.enable = false;
      systemd-boot.enable = true;
    };
    home-manager = {
      packages = {
        git.enable = true;
      };
    };
  };
}
