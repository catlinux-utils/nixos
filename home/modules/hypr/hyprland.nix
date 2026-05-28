{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    home.packages = with pkgs; [
      grim
      wl-clipboard
      playerctl
      brightnessctl
      rofi
      hyprshot

      glibcLocales

      hyprshutdown

    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
    };
    home.file.".config/hypr/hyprland.lua".source = ../../../config/hyprland/hyprland.lua;
  };
}
