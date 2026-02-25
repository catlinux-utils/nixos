{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    home.packages = with pkgs; [
      cantarell-fonts
      materia-theme
      grim
      wl-clipboard
      playerctl
      brightnessctl
      rofi
      hyprshot

      glibcLocales

    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      settings = {
        monitor = [ ",preferred,auto,1" ];

        general = {
          # Gaps and border
          gaps_in = 1;
          gaps_out = 1;
          gaps_workspaces = 50;
          border_size = 1;

          resize_on_border = true;
          no_focus_fallback = true;
          layout = "dwindle";

          "col.active_border" = "rgba(0,0,0,0)";
          "col.inactive_border" = "rgba(0,0,0,0)";

          #focus_to_other_workspaces = true # ahhhh i still haven't properly implemented this
          allow_tearing = true; # This just allows the `immediate` window rule to work
        };

        decoration = {
          rounding = 10;

          blur = {
            enabled = true;
            xray = true;
            special = false;
            new_optimizations = true;
            size = 14;
            passes = 4;
            brightness = 1;
            noise = 0.01;
            contrast = 1;
            popups = true;
            popups_ignorealpha = 0.6;
          };
          # Shadow
          shadow = {
            enabled = true;
            ignore_window = true;
            range = 20;
            offset = "0 2";
            render_power = 4;
            color = "rgba(0000002A)";
          };

          # Dim
          dim_inactive = false;
          dim_strength = 0.1;
          dim_special = 0;

        };

        input = {
          kb_layout = "pl";
          numlock_by_default = true;
          repeat_delay = 250;
          repeat_rate = 35;

          touchpad = {
            natural_scroll = "yes";
            disable_while_typing = true;
            clickfinger_behavior = true;
            scroll_factor = 0.5;
          };
          special_fallthrough = true;
          follow_mouse = 1;
          accel_profile = "flat";
        };

        device = {
          name = "logitech-usb-receiver-mouse";
          sensitivity = -0.50;
          accel_profile = "adaptive";
        };

        animations = {
          enabled = true;
          bezier = [
            "linear, 0, 0, 1, 1"
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92"
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "menu_decel, 0.1, 1, 0, 1"
            "menu_accel, 0.38, 0.04, 1, 0.07"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
            "softAcDecel, 0.26, 0.26, 0.15, 1"
            "md2, 0.4, 0, 0.2, 1"
          ];
          animation = [
            "windows, 1, 3, md3_decel, popin 60%"
            "windowsIn, 1, 3, md3_decel, popin 60%"
            "windowsOut, 1, 3, md3_accel, popin 60%"
            "border, 1, 10, default"
            "fade, 1, 3, md3_decel"
            "layersIn, 1, 3, menu_decel, slide"
            "layersOut, 1, 1.6, menu_accel"
            "fadeLayersIn, 1, 2, menu_decel"
            "fadeLayersOut, 1, 4.5, menu_accel"
            "workspaces, 1, 7, menu_decel, slide"
            "specialWorkspace, 1, 3, md3_decel, slidevert"
          ];
        };

        dwindle = {
          preserve_split = true;
          permanent_direction_override = true;
        };

        master = {
          new_status = "master";
        };

        binds = {
          scroll_event_delay = 0;
          allow_workspace_cycles = "yes";
        };

        misc = {
          vfr = 1;
          vrr = 1;
          focus_on_activate = true;
          animate_manual_resizes = false;
          animate_mouse_windowdragging = false;
          enable_swallow = false;
          swallow_regex = "(foot|kitty|allacritty|Alacritty)";

          disable_hyprland_logo = true;
          force_default_wallpaper = 0;
          allow_session_lock_restore = true;

          initial_workspace_tracking = 2;

          background_color = "rgba(0, 0, 0, 1)";
        };

        exec-once = [
          "uwsm app -- dbus-update-activation-environment --all"
          #"uwsm app -- hyprpm reload" # disable
          # "uwsm app -- ~/.config/hypr/scripts/gtk-setup.sh"
          "gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'"
          "gsettings set org.gnome.desktop.interface cursor-theme Adwaita"
          "gsettings set org.gnome.desktop.interface gtk-theme Materia-dark-compact"
          "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
          "gsettings set org.cinnamon.desktop.default-applications.terminal exec kitty"
          # "uwsm app -- ags run --gtk 3"
          # "uwsm app -- nm-applet --indicator"
          # "uwsm app -- dunst"

        ];
        bind = [
          "Super, Q, killactive"
          "Super+Alt, Space, togglefloating"
          "Super, I, togglesplit"
          "Super, F, fullscreen"
          "Alt, TAB, workspace,previous"
          #Apps
          "Super, T, exec, uwsm app -- kitty.desktop"
          "Super, W, exec, uwsm app -- brave-browser.desktop"
          "Super, C, exec, uwsm app -- code.desktop"
          "Super, E, exec, uwsm app -- nemo.desktop"
          "Super, R, exec, pidof rofi & killall rofi || uwsm app -- rofi -show drun -location 1 -config ~/.config/rofi/config.rasi -terminal kitty -run-command 'uwsm app -- {cmd}'"
          #CaptureScreen
          "Ctrl+Alt, R, exec, ~/.config/hyprland/scripts/record-script.sh --fullscreen"
          " ,Print, exec, grim - | wl-copy"
          "Super SHIFT, S, exec, hyprshot -m region -z"
          #Session
          "Super, O, exec, loginctl lock-session"
          "Super, M, exec, uwsm stop"
          #MoveFocus
          "Super, h, movefocus, l"
          "Super, j, movefocus, r"
          "Super, k, movefocus, u"
          "Super, l, movefocus, d"
          #MoveWindow
          "Super+Shift, h, movewindow, l"
          "Super+Shift, j, movewindow, r"
          "Super+Shift, k, movewindow, u"
          "Super+Shift, l, movewindow, d"
          #SwitchWorkspace
          "Super, 1, workspace, 1"
          "Super, 2, workspace, 2"
          "Super, 3, workspace, 3"
          "Super, 4, workspace, 4"
          "Super, 5, workspace, 5"
          "Super, 6, workspace, 6"
          "Super, 7, workspace, 7"
          "Super, 8, workspace, 8"
          "Super, 9, workspace, 9"
          "Super, 0, workspace, 10"
          #SwitchWorkspaceScroll
          "Super, mouse_up, workspace, +1"
          "Super, mouse_down, workspace, -1"
          #MoveWorkspace
          "Super+Alt, 1, movetoworkspacesilent, 1"
          "Super+Alt, 2, movetoworkspacesilent, 2"
          "Super+Alt, 3, movetoworkspacesilent, 3"
          "Super+Alt, 4, movetoworkspacesilent, 4"
          "Super+Alt, 5, movetoworkspacesilent, 5"
          "Super+Alt, 6, movetoworkspacesilent, 6"
          "Super+Alt, 7, movetoworkspacesilent, 7"
          "Super+Alt, 8, movetoworkspacesilent, 8"
          "Super+Alt, 9, movetoworkspacesilent, 9"
          "Super+Alt, 0, movetoworkspacesilent, 10"
          #SpecialWorkspace
          "Super, S, togglespecialworkspace, magic"
          "Super CTRL, S, movetoworkspace, special:magic"
          #ControlBrightness
          " , XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          " , XF86MonBrightnessUp, exec, brightnessctl set +5%"

        ];
        bindm = [
          # MouseMoveResize
          "Super, mouse:272, movewindow"
          "Super, mouse:273, resizewindow"
        ];
        bindel = [
          #ControlVolume
          " , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          " , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];
        bindl = [
          " , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          #ControlMedia
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        workspace = [
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
        ]
        ++ (optionals (vars.modules.desktop-environment.hyprland.twomonitors or false) [
          "1, monitor:DP-3"
          "2, monitor:DP-3"
          "3, monitor:DP-3"
          "4, monitor:DP-3"
          "5, monitor:DP-3"
          "6, monitor:HDMI-A-1"
          "7, monitor:HDMI-A-1"
          "8, monitor:HDMI-A-1"
          "9, monitor:HDMI-A-1"
          "10, monitor:HDMI-A-1"
        ]);

        windowrule = [
          #"match:xwayland true, match:float true, match:fullscreen false, match:pin false, no_focus true"
          "match:title ^(Picture(-| )in(-| )[Pp]icture)$, match:title ^(Obraz w obrazie)$, float true, size 608 342, keep_aspect_ratio true, pin true"
          "match:class ^(xdg-desktop-portal-gtk)$, float true, center true"
          "match:class (.*\.exe), match:class (steam_app), immediate true"
          "match:float false, no_shadow true"
          "match:class steam, match:title Steam, center true, opacity 1 1"
          "match:class steam, match:title Friends List, match:title Lista znajomych, float 1, size 300 800, no_focus false"
          "match:title Arma Reforger, render_unfocused true" # arma reforger fix?
          "match:class steam21, idle_inhibit fullscreen"
          "border_size 0, match:float 0, match:workspace w[tv1]"
          "rounding 0, match:float 0, match:workspace w[tv1]"
          "border_size 0, match:float 0, match:workspace f[1]"
          "rounding 0, match:float 0, match:workspace f[1]"
        ];
        layerrule = [
          "match:class (.*), xray 1,"
        ];
      };
    };

  };
}
