# PLACEHOLDER: copied from hosts/pc-main just so this host evaluates.
# Regenerate on the actual machine before deploying:
#   sudo nixos-generate-config --show-hardware-config > hosts/laptop-main/hardware-configuration.nix
# Do not boot/install with these UUIDs - they belong to pc-main's disks.
{ lib, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e391136a-6ecb-47c8-a528-1b0f51545905"; # FIXME: pc-main's disk
    fsType = "btrfs";
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/8C8A-92AD"; # FIXME: pc-main's ESP
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
