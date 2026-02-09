{ pkgs }:

rec {
  user = "cat";
  initialPassword = "cat";
  networkingHostName = "nixos";
  timezone = "Europe/Warsaw";
  defaultLocale = "pl_PL.UTF-8";
  flakeLocation = "/home/${user}/github/nixos";
  consoleFont = "Lat2-Terminus16";
  modules = {
    desktop-environment = {
      hyprland = {
        enable = false;
      };
    };
    home-manager = {
      packages = {
        git = {
          enable = true;
          name = "ThePolishCat";
          email = "damianadam000@gmail.com";

        };
      };
    };
  };
}
