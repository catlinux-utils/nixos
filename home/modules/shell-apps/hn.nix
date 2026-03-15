{ vars, ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.dates = "weekly";
    clean.extraArgs = "--keep 5 --keep-since 3d";
    flake = vars.flakeLocation + "#" + vars.conf-name;
  };
}
