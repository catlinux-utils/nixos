# NixOS Configuration

A modular, multi-host NixOS flake with Home Manager (integrated as NixOS module), Hyprland, and QuickShell.

## 📋 Hosts

| Host | Hostname | Hardware | Desktop | Purpose |
|------|----------|----------|---------|---------|
| `laptop-main` | `nixos` | Framework 13 AMD | Hyprland + QuickShell | Daily driver |
| `pc-main` | `nixos` | Custom desktop | Hyprland (dual monitor) + QuickShell | Main desktop |
| `vm-desktop` | `nixos` | QEMU/KVM VM | Hyprland + QuickShell | Desktop VM |
| `vm` | `nixos` | QEMU/KVM VM | Headless | Server VM |
| `server1` | `nixos-server1` | Server hardware | Headless | Home server |
---

## 🚀 Quick Start

### Prerequisites

- NixOS installed (or Nix on another Linux distro)
- Flakes enabled: `nix.settings.experimental-features = [ "nix-command" "flakes" ];`
- Git

### New Machine Setup

```bash
# 1. Clone the repository
git clone https://github.com/ThePolishCat/nixos.git ~/github/nixos
cd ~/github/nixos

# 2. Generate hardware config (run on target machine)
sudo nixos-generate-config --show-hardware-config > hosts/<your-host>/hardware-configuration.nix

# 3. Create host config
cp hosts/pc-main/config-modules.nix hosts/<your-host>/config-modules.nix
# Edit hosts/<your-host>/config-modules.nix with your user, hostname, modules, etc.

# 4. Build and switch
sudo nixos-rebuild switch --flake .#<your-host>
```

### Update Existing Machine

```bash
cd ~/github/nixos
git pull
sudo nixos-rebuild switch --flake .#<your-host>
```

---

## ⚙️ Host Configuration

Each host is defined in `hosts/<host>/config-modules.nix`:

```nix
{ pkgs }:
rec {
  conf-name = "your-host";              # Config name
  user = "youruser";                     # Username
  initialPassword = "changeme";          # Change on first login!
  networkingHostName = "nixos";          # Hostname
  timezone = "Europe/Warsaw";            # Timezone
  defaultLocale = "pl_PL.UTF-8";         # Locale
  flakeLocation = "/home/${user}/github/nixos";

  modules = {
    # Enable modules per host
    display-manager = { greeter.enable = true; };
    ollama.enable = true; 
    virtualisation.enable = true; 
    desktop-environment = {
      hyprland.enable = true; 
    };
    home-manager = {
      packages = {
        git = { name = "Your Name"; email = "you@example.com"; };
      };
    };
  };
}
```
---

## 🛠️ Development

### Add a New Host

```bash
mkdir -p hosts/my-new-host
sudo nixos-generate-config --show-hardware-config > hosts/my-new-host/hardware-configuration.nix
cp hosts/pc-main/config-modules.nix hosts/my-new-host/config-modules.nix
# Edit config-modules.nix
nix build .#nixosConfigurations.my-new-host.config.system.build.toplevel
sudo nixos-rebuild switch --flake .#my-new-host
```

### Add a New Module

1. Create `system/modules/<category>/my-module.nix` or `home/modules/<category>/my-module.nix`
2. Auto-imported via `lib.filesystem.listFilesRecursive`
3. Add to host's `modules` in `config-modules.nix` if toggling per-host

### Update Flake Inputs

```bash
nix flake update
# Or specific input
nix flake lock --update-input nixpkgs
```

### Format & Lint

```bash
nix fmt                    # Format all Nix files
nix run nixpkgs#statix check .   # Lint (if configured)
nix run nixpkgs#deadnix .        # Dead code check (if configured)
```

---

## 🖥️ Desktop Environment

**Hyprland** (Wayland compositor) + **QuickShell** (QML bar/widgets).

Keybindings (from `config/hyprland/hyprland.lua`):
- `SUPER + RETURN` — Terminal (Kitty)
- `SUPER + SPACE` — Rofi launcher
- `SUPER + SHIFT + Q` — Close window
- `SUPER + [1-9]` — Workspace switch
- `SUPER + SHIFT + [1-9]` — Move window to workspace
- `SUPER + V` — Toggle floating
- `SUPER + F` — Fullscreen

Theming: Catppuccin Mocha via `home/modules/hypr/theming.nix` and `config/quickshell/Theme.qml`.

External configs (linked via Home Manager):
- `config/hyprland/hyprland.lua` — Hyprland config
- `config/quickshell/shell.qml` — QuickShell bar
- `config/quickshell/hyprland.lua` — QuickShell ↔ Hyprland integration
- `config/wallpaper/arch-windows.png` — Wallpaper

---

## 📚 Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nixpkgs Manual](https://nixos.org/manual/nixpkgs/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [QuickShell Docs](https://quick-shell.github.io/docs/)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)

---

## 📄 License

MIT — see [LICENSE](LICENSE).

**Author**: [ThePolishCat](https://github.com/ThePolishCat)  
**Repository**: [github.com/ThePolishCat/nixos](https://github.com/ThePolishCat/nixos)