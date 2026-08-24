{
  lib,
  pkgs,
  vars,
  ...
}:
with lib;
{
  config = mkMerge [
    { programs.zsh.enable = true; }

    (mkIf (vars.modules.desktop-environment.hyprland.enable or false) {
      services.flatpak.enable = true;
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
      ];
      programs.appimage = {
        enable = true;
        binfmt = true;
      };
      environment.systemPackages = [
        pkgs.distrobox
      ];
    })

    (mkIf (vars.modules.gaming.enable or false) {
      programs.steam.enable = true;
    })
  ];
}
