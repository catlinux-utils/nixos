{
  pkgs,
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
}
