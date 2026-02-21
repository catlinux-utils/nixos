{ pkgs, vars, ... }:

{

  boot = {

    kernelPackages = pkgs.linuxPackages_zen;
    initrd.systemd.enable = true;

    loader = {

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };

      limine = {
        enable = true;
        enableEditor = false;
        panicOnChecksumMismatch = true;
        secureBoot.enable = true;
        resolution = "max";
        maxGenerations = 4;
        style.wallpapers = [ ];
        extraEntries = ''
          /Windows
            protocol: efi_chainload
            path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
            comment: Microsoft bootloader
          /Memtest86
            protocol: linux
            kernel_path: boot():/limine/efi/memtest86/memtest.efi
            comment: Memtest86+
        '';
        additionalFiles = {
          "efi/memtest86/memtest.efi" = "${pkgs.memtest86plus.efi}";
        };

      };
    };
  };
  environment.systemPackages = with pkgs; [
    efibootmgr
    sbctl
    memtest86plus

  ];
}
