{
  inputs,
  pkgs,
  nixpkgs,
  home-manager,
}:
let
  system = "x86_64-linux";

  hostNames = builtins.sort (a: b: a < b) (
    builtins.filter (name: builtins.pathExists ./${name}/config-modules.nix) (
      builtins.attrNames (builtins.readDir ./.)
    )
  );

  hosts = builtins.listToAttrs (
    map (name: {
      name = name;
      value = import ./${name}/config-modules.nix { inherit pkgs; };
    }) hostNames
  );

  makeNixosConfiguration =
    hostName:
    let
      vars = hosts.${hostName};
    in
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs vars; };
      modules = [
        ./${hostName}/hardware-configuration.nix
        ../system
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs vars; };
          home-manager.users.${vars.user} = {
            imports = [ ../home ];
          };
        }
      ];
    };

in
{
  configurations = builtins.listToAttrs (
    map (name: {
      name = name;
      value = makeNixosConfiguration name;
    }) hostNames
  );
  descriptions = builtins.listToAttrs (
    map (name: {
      name = name;
      value = "NixOS configuration for ${name}";
    }) hostNames
  );
}
