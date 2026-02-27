{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    nodejs
    yt-dlp
    ffmpeg
  ];
}
