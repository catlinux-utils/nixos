rec {
  conf-name = "laptop-main";
  user = "cat";
  initialPassword = "cat";
  networkingHostName = "nixos-laptop-main";
  timezone = "Europe/Warsaw";
  defaultLocale = "pl_PL.UTF-8";
  flakeLocation = "/home/${user}/github/nixos";
  modules = {
    display-manager = {
      greeter.enable = true;
    };
    desktop-environment = {
      hyprland.enable = true;
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
