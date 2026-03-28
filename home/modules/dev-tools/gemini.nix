{
  pkgs,
  config,
  ...
}:

{
  programs.gemini-cli = {
    enable = true;
  };
}
