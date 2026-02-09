# In flake.nix/home.nix where you call home-manager:
specialArgs = let vars = desktop; in { 
  inherit inputs vars;
  modulesConfig = vars.modules.home-manager;  # Pass the whole config
};

# In your main home-manager file:
{ config, pkgs, vars, modulesConfig, ... }:
{
  imports = [ ./hosts/desktop/mime-defaultapps.nix ];
  
  # Now both imported modules AND this module get modulesConfig
  
  # Optional: Still assign to module for backward compatibility
  module = {
    packages.enable = (modulesConfig.packages.enable or true);
    # ... etc
  };
}

# In mime-defaultapps.nix:
{ config, pkgs, modulesConfig, ... }:
lib.mkIf (modulesConfig.packages.enable or false) {
  # Module-specific config
}