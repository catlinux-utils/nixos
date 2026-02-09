{ pkgs }:

rec {
  user = "cat";
  flakeLocation = "/home/${user}/github/nixos";
  networkingHostName = "nixos";
  timezone = "Europe/Warsaw";
  defaultLocale = "pl_PL.UTF-8";
  consoleFont = "Lat2-Terminus16";
  initialPassword = "$y$j9T$8zHiYDS6ygvXsdcgXn2pg1$6BkJP/RL33k.q5vUPfXyT0DelCZEt8RbUAcDysQ22A3";
  nixExtraOptions = "experimental-features = nix-command flakes";
  efiSysMountPoint = "/boot/efi";
  grubDevice = "nodev";
  configurationLimit = 10;
  gtk = {
    cursorSize = 24;
    cursorTheme = "macOS";
    cursorPackage = pkgs.apple-cursor;
    gtkThemePackage = (
      pkgs.orchis-theme.override {
        border-radius = 3;
        tweaks = [
          "compact"
          "macos"
          "submenu"
        ];
      }
    );
    gtkTheme = "Orchis-Dark";
    gtkIconTheme = "Adwaita";
    gtkFontName = "Ubuntu Sans 11";
    preferDarkTheme = 1;
    favoriteApps = [
      "kitty.desktop"
      "brave-browser.desktop"
      "org.gnome.Nautilus.desktop"
      "org.gnome.TextEditor.desktop"
    ];
  };
  modules = {
    configuration.enable = true; # use default configuration.nix file
    wifi.enable = true; # enable wifi hotfix (disable scanRandMacAddress)
    overlay = {
      pkgs.enable = true; # nix pkgs overlays
    };
    bootloader = {
      grub.enable = false;
      systemd-boot.enable = true;
    };
    drive = {
      ssd.enable = true;
      ntfs.enable = true;
    };
    hardware = {
      bluetooth = {
        enable = true;
        blueman.enable = modules.hardware.bluetooth.enable;
      };
      wireless.enable = false;
      amd-gpu.enable = false;
      opengl.enable = modules.hardware.amd-gpu.enable;
    };
    virtualisation = {
      enable = false;
      virt-manager.enable = false;
      spice-virt-manager.enable = false;
      docker = {
        enable = false;
        warden.enable = false;
        xdebug-ports.enable = false;
      };
    };
    shell = {
      fish.enable = true;
      default-fish.enable = true;
    };
    xdg.enable = true;
    desktop-environment = {
      hyprland = {
        enable = true;
        services.enable = modules.desktop-environment.hyprland.enable;
      };
      plasma6.enable = false;
      gnome = {
        enable = true;
        auto-login.enable = false;
      };
      cosmic.enable = false;
    };
    display-manager = {
      gdm = {
        enable = true;
        custom-background.enable = true;
        backgroundImagePath = "file:///etc/nixos/lockscreen.jpg";
      };
    };
    screen-locker = {
      hyprlock.enable = true;
      swaylock.enable = false;
      gtklock.enable = false;
    };
    security = {
      polkit.enable = true;
    };
    bar = {
      ags.enable = true;
      waybar.enable = false;
    };
    services = {
      udev = {
        rangoli.enable = false;
        headsetcontrol.enable = true;
      };
      i2c.enable = true;
      numlock-on-tty.enable = true;
      nix-diff.enable = true;
    };
    security = {
      doas.enable = false;
    };
    programs = {
      devenv.enable = false;
      localsend.enable = true;
      chrome = {
        widevine.enable = true;
      };
      teamviewer.enable = false;
      copyq.enable = true;
      ydotool.enable = modules.programs.copyq.enable;
      nh.enable = false;
      openrazer.enable = false;
      extraHosts = ''
        127.0.0.1 ::1 magento2.rooter.test
        127.0.0.1 ::1 test.rooter.test
        127.0.0.1 ::1 rooter.rooter.test
        127.0.0.1 ::1 magento2.test
      '';
    };
    home-manager = {
      packages = {
        enable = true; # shared packages
        git.enable = true;
        terminator.enable = false;
        chrome.enable = false;
        librewolf.enable = true;
        xterm.enable = false;
        mpv.enable = true;
        fastfetch.enable = true;
        brave.enable = true;
        vscode.enable = true;
        zoxide.enable = true;
        phpstorm.enable = true;
        distrobox.enable = false;
        rooter.enable = false;
        kdeconnect.enable = false;
        eza.enable = true;
        bat.enable = false;
        fd.enable = false;
        ripgrep.enable = false;
        kitty.enable = true;
        ghostty.enable = true;
        yazi.enable = true;
        micro.enable = true;
        peco.enable = true;
        copyq.enable = modules.programs.copyq.enable;
        localsend.enable = modules.programs.localsend.enable;
        teamviewer.enable = modules.programs.teamviewer.enable;
        albert.enable = false;
        rofi.enable = false;
        swaync.enable = false;
      };
      scripts = {
        yeelight.enable = true;
        startup.enable = true;
        bluetoothbatterypercentage.enable = false;
        btupowerbatterypercentage.enable = false;
        yrweather.enable = true;
        openweathermap.enable = true;
        toggleidle.enable = true;
        nightlight.enable = true;
        note.enable = true;
        screenshot.enable = true;
        openstartupapps.enable = true;
        idle.enable = true;
        powermenu.enable = true;
        wakefromsleep.enable = true;
        ngrokwarden.enable = modules.virtualisation.docker.warden.enable;
        headset.enable = true;
        monitor.enable = true;
        resetbluetoothags.enable = false;
        sys.enable = true;
        clipboardtoggle.enable = false;
        sync.enable = true;
        exportbluetoothinfo.enable = true;
        setaudiosource.enable = true;
      };
      shell = {
        aliases.enable = true;
        fish = {
          enable = true;
          plugins = {
            enable = modules.home-manager.shell.fish.enable;
            autopair.enable = modules.home-manager.shell.fish.plugins.enable;
            done.enable = false;
            sponge.enable = modules.home-manager.shell.fish.plugins.enable;
            tide.enable = modules.home-manager.shell.fish.plugins.enable;
          };
          omf-commands.enable = false;
        };
        bash = {
          enable = true;
          bashrc.enable = true;
          blesh.enable = false;
        };
        docker.enable = modules.virtualisation.docker.enable;
        warden = {
          enable = modules.virtualisation.docker.warden.enable;
          aliases.enable = false;
        };
      };
    };
  };
}
