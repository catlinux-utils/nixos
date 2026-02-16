{ pkgs, vars, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 6;
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/efi";
  };
  boot.initrd = {
    systemd.enable = true;
  };
  environment.systemPackages = [
    pkgs.efibootmgr
  ];
}
