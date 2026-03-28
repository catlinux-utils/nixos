{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
  };

  services.flatpak.enable = true;

}
