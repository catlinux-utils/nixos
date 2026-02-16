{ lib, vars, ... }:

with lib;

{
  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    # FIXME: https://github.com/NixOS/nixpkgs/issues/484328
    services.displayManager.defaultSession = "hyprland-uwsm";

    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/start-hyprland";
        };
      };
    };
    # FIXME END
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    # Keyring
    security.pam.services.login.enableGnomeKeyring = true;
    services.gnome.gnome-keyring.enable = true;

    # Pipewire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    programs.dconf.enable = true;

  };

}
