{
    description = "nix";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url= "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = { self, nixpkgs, home-manager, ... } : {
         nixosConfigurations.cat = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.cat = import ./home.nix;
                        backupFileExtension = "backup";
                    };
                }
            ];
         };
    };
}
