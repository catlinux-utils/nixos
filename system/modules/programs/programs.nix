{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
  };

  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

  ];

}
