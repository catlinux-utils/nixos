{
  description = "nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      hostNames = builtins.sort (a: b: a < b) (builtins.filter (name:
        builtins.pathExists ./system/hosts/${name}/config-modules.nix
      ) (builtins.readDir ./system/hosts));

      hosts = builtins.listToAttrs (map (name:
        { name = name;
          value = import ./system/hosts/${name}/config-modules.nix { inherit pkgs; };
        }
      ) hostNames);

      makeNixosConfiguration = hostName:
        let
          vars = hosts.${hostName};
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs vars; };
          modules = [
            ./system/hosts/${hostName}/hardware-configuration.nix
            ./system/modules.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs vars; };
              home-manager.users.${vars.user} = {
                imports = [ ./home/home.nix ];
              };
            }
          ];
        };

    in
    {
      nixosConfigurations = builtins.listToAttrs (map (name:
        { name = name; value = makeNixosConfiguration name; }
      ) hostNames);
    };
}
