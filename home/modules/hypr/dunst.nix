{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    services.dunst = {
      enable = true;
      settings = {
        global = {
          monitor = 1; # default: 0
          follow = "mouse"; # default: "none"
          height = "(0, 300)"; # default: 0
          frame_color = "#000000"; # default: "#888888"
          stack_duplicates = true; # default: false
          enable_recursive_icon_lookup = true; # default: false (assumed)
          icon_theme = "Adwaita"; # default: unset (uses system theme)
          corner_radius = 10; # default: 0
        };
        urgency_low = {
          background = "#000000C0"; # default: "#222222"
          default_icon = "dialog-information"; # customization
        };
        urgency_normal = {
          background = "#000000C0"; # default: "#285577"
          override_pause_level = 30; # default: 0
          default_icon = "dialog-information"; # customization
        };
        urgency_critical = {
          background = "#000000C0"; # default: "#900000"
          frame_color = "#ff0000"; # default: global frame_color
          override_pause_level = 60; # default: 0
          default_icon = "dialog-warning"; # customization
        };
      };
    };
  };
}
