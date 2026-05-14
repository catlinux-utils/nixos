-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/
-- Please note not all available settings / options are set here.
-- For a full list, see the wiki
-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,
        gaps_workspaces = 50,
        border_size = 1,

        resize_on_border = true,
        no_focus_fallback = true,

        allow_tearing = false,

        col = {
            active_border   = "rgba(0,0,0,0)",
            inactive_border = "rgba(0,0,0,0)",
        },

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    input = {
        kb_layout = "pl",
        numlock_by_default = true,
        repeat_delay = 250,
        repeat_rate = 35,

        touchpad = {
            natural_scroll = "yes",
            clickfinger_behavior = true,
            scroll_factor = 0.5,
        },
        special_fallthrough = true,
        follow_mouse = 1,
        accel_profile = "flat",
    },

    animations = {
        enabled = true,
    },

    dwindle = {
      preserve_split = true,
      smart_split = true,
    },
    binds = {
        scroll_event_delay = 0,
        allow_workspace_cycles = "yes",
    },
    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
        allow_session_lock_restore = true,

        initial_workspace_tracking = 2,

        background_color = "rgba(0, 0, 0, 1)",
    },
})

hl.device({
    name = "logitech-usb-receiver-mouse",
    sensitivity = -0.50,
    accel_profile = "adaptive",
})

local monitors = hl.get_monitors()
local has_dp3, has_hdmi_a1 = false, false

for _, mon in ipairs(monitors) do
    if mon.name == "DP-3" then has_dp3 = true end
    if mon.name == "HDMI-A-1" then has_hdmi_a1 = true end
end

if has_dp3 and has_hdmi_a1 then
    for i = 1, 5 do hl.workspace_rule({ workspace = tostring(i), monitor = "DP-3" }) end
    for i = 6, 10 do hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1" }) end
end

hl.on("hyprland.start", function () 
  hl.exec_cmd("uwsm app -- dbus-update-activation-environment --all")
end)


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/


-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })




-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more



---------------------
---- KEYBINDINGS ----
---------------------


hl.bind("Super + Q", hl.dsp.window.close())
hl.bind("Super + Shift + C", hl.dsp.window.kill())

hl.bind("Super + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || uwsm stop'"))

hl.bind("Super + Alt + Space", hl.dsp.window.float())
hl.bind("Super + I", hl.dsp.layout("togglesplit"))
hl.bind("Super + F", hl.dsp.window.fullscreen())
hl.bind("Alt + Tab", hl.dsp.focus("previous"))

hl.bind("Super + T", hl.dsp.exec_cmd("uwsm app -- kitty.desktop"))
hl.bind("Super + W", hl.dsp.exec_cmd("uwsm app -- brave-browser.desktop"))
hl.bind("Super + C", hl.dsp.exec_cmd("uwsm app -- code.desktop"))
hl.bind("Super + E", hl.dsp.exec_cmd("uwsm app -- nemo.desktop"))
hl.bind("Super + R", hl.dsp.exec_cmd("pidof rofi & killall rofi || uwsm app -- rofi -show drun -location 1 -config ~/.config/rofi/config.rasi -terminal kitty -run-command 'uwsm app -- {cmd}'"))

hl.bind("Super + left",  hl.dsp.focus({ direction = "left" }))
hl.bind("Super + right", hl.dsp.focus({ direction = "right" }))
hl.bind("Super + up",    hl.dsp.focus({ direction = "up" }))
hl.bind("Super + down",  hl.dsp.focus({ direction = "down" }))

hl.bind("Super + Shift + left",  hl.dsp.focmoveus({ direction = "left" }))
hl.bind("Super + Shift + right", hl.dsp.move({ direction = "right" }))
hl.bind("Super + Shift + up",    hl.dsp.move({ direction = "up" }))
hl.bind("Super + Shift + down",  hl.dsp.move({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("Super + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind("Super + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind("Super + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind("Super + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("Super + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind("Super + mouse_up",   hl.dsp.focus({ workspace = "-1" }))

hl.bind("Super + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("Super + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({ match = { title = "^(Picture(-| )in(-| )[Pp]icture)$|^(Obraz w obrazie)$" }, floating = true, size = { 608, 342 }, keep_aspect_ratio = true, pin = true })
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, floating = true, center = true })
--hl.window_rule({ match = { class = "^(.*\\.exe|steam_app)$" },immediate = true })
hl.window_rule({ match = { floating = false }, no_shadow = true })
hl.window_rule({ match = { class = "^steam$", title = "^(Steam)$" }, center = true, opacity = 1.0 })
hl.window_rule({ match = { class = "^steam$", title = "^(Friends List|Lista znajomych)$" }, floating = true, size = { 300, 800 }, no_focus = false })
hl.window_rule({ match = { title = "^Arma Reforger$" }, render_unfocused = true })
hl.window_rule({ match = { class = "^steam21$" }, idle_inhibit = "fullscreen" })


-- smart gaps / no gaps when only one window - per workspace
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

hl.layer_rule({ match = { class = ".*" }, xray = 1 })