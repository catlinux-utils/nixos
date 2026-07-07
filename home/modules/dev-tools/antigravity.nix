{
  pkgs,
  config,
  ...
}:

{
  programs.antigravity-cli = {
    enable = true;
  };
  programs.antigravity = {
    enable = true;
  };
}
