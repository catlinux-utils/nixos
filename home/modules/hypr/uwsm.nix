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
        # GTK
        #export GDK_BACKEND=wayland,x11,*

        # QT
        #export QT_AUTO_SCREEN_SCALE_FACTOR=1
        #export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      '';
      ".config/uwsm/env-hyprland".text = ''
        export HYPRCURSOR_THEME=Adwaita
        export HYPRCURSOR_SIZE=24
      '';

    };
  };
}
