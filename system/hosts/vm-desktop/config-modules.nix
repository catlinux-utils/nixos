{ pkgs }:

rec {
  user = "cat";
  initialPassword = "cat";
  networkingHostName = "nixos";
  timezone = "Europe/Warsaw";
  defaultLocale = "pl_PL.UTF-8";
  flakeLocation = "/home/${user}/github/nixos";
  modules = {
    vm = {
      enable = true;
    };
    display-manager = {
      gdm = {
        enable = true;
      };
    };
    desktop-environment = {
      hyprland = {
        enable = true;
      };
    };
    home-manager = {
      packages = {
        git = {
          name = "ThePolishCat";
          email = "88453875+PolskiKocurek@users.noreply.github.com";

        };
      };
    };
  };
}
