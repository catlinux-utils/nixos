{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    home.packages = [
      pkgs.nerd-fonts.meslo-lg
    ];

    programs.kitty = {
      enable = true;
      settings = {
        font_family = "MesloLGS Nerd Font Mono";
        font_size = 10;
        scrollback_lines = 10000;
        confirm_os_window_close = 2;
        enable_audio_bell = false;
        background_opacity = 0.6;

        "map page_up" = " scroll_page_up";
        "map page_down" = " scroll_page_down";

      };
    };

    xdg.mimeApps.defaultApplications = {
      "mimetype" = "kitty.desktop";
      "application/x-terminal-emulator" = "kitty.desktop";
      "x-terminal-emulator" = "kitty.desktop";
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
  };
}
