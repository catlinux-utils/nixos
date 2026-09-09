{
  pkgs,
  config,
  ...
}:

{
  home.packages = with pkgs; [
    python3
    gnumake
    gcc
  ];
}
