{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    programs.chromium = {
      enable = true;
      package = pkgs.brave;
      commandLineArgs = [
        "--password-store=gnome-libsecret"
        "--enable-accelerated-video-decode"
        "--disable-features=WaylandWpColorManagerV1"
      ];

    };
    xdg.mimeApps.defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";
    };

    home.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
    };
  };
}
