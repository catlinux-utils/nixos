{ vars, ... }:

{
  home.username = "${vars.user}";
  home.homeDirectory = "/home/${vars.user}";

  imports = [
    ./modules/git.nix
    ./modules/zsh.nix
  ];
  home.stateVersion = "25.11";
}
