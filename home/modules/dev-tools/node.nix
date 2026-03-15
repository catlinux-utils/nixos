{
  pkgs,
  config,
  ...
}:

{
  home.packages = with pkgs; [
    # nodejs
    # yt-dlp
    # ffmpeg
    # python3
    # gnumake
    # gcc
    # libopus
    # libuuid
    # cairo
    # pango
    # libjpeg
    # giflib
    # librsvg
  ];
  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];
}
