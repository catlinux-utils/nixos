{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {
    home.file = {
      ".config/uwsm/env".text = ''
        # XDG
        export XDG_CURRENT_DESKTOP=Hyprland
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=Hyprland

        # GTK
        export GDK_BACKEND=wayland,x11,*

        # QT
        export QT_AUTO_SCREEN_SCALE_FACTOR=1
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export QT_QPA_PLATFORMTHEME=qt6ct
      '';
      ".config/uwsm/env-hyprland".text = ''
        export HYPRCURSOR_THEME=Adwaita
        export HYPRCURSOR_SIZE=24
      '';

    };
  };
}
