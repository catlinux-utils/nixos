{ vars, ... }:
{
  imports = [
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/nixos.nix
    ./modules/programs.nix
    ./modules/time.nix
    ./modules/users.nix

  ];
}
