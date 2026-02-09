{config, pkgs , ...}:

{
    home.username = "cat";
    home.homeDirectory = "/home/cat";
    home.stateVersion = "25.11";
    programs.bash = {
        enable = true;
        shellAliases = {
            btw = "echo hyprland";
        };
    };
}
