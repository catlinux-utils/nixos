{ lib, vars, ... }:
with lib;

{
  config = mkIf (vars.modules.ollama.enable or false) {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      rocmOverrideGfx = "10.3.0";
    };
    boot.initrd.kernelModules = [ "amdgpu" ];

  };

}
