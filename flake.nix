{
  description = "nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

      pc-main = import ./system/hosts/pc-main/config-modules.nix { inherit pkgs; };
      vm = import ./system/hosts/vm/config-modules.nix { inherit pkgs; };
    in
    {
      nixosConfigurations = {
        pc-main = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs =
            let
              vars = pc-main;
            in
            {
              inherit inputs vars;
            };
          modules = [
            ./system/hosts/pc-main/hardware-configuration.nix
            ./system/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs =
                let
                  vars = pc-main;
                in
                {
                  inherit inputs vars;
                };
              home-manager.users.${pc-main.user} = {
                imports = [ ./home/home.nix ];
              };
            }
          ];
        };
        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs =
            let
              vars = vm;
            in
            {
              inherit inputs vars;
            };

          modules = [
            ./system/hosts/vm/hardware-configuration.nix
            ./system/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs =
                let
                  vars = vm;
                in
                {
                  inherit inputs vars;
                };
              home-manager.users.${vm.user} = {
                imports = [ ./home/home.nix ];
              };
            }
          ];
        };
      };
    };
}
