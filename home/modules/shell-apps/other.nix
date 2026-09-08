{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;
{
  config = mkMerge [
    {
      home.packages = with pkgs; [
        ncdu
        duf
        unzip
        p7zip
        yt-dlp
        ffmpeg
      ];
    }

    (mkIf (vars.modules.desktop-environment.hyprland.enable or false) {
      home.packages = with pkgs; [ lmstudio ];
    })
}
