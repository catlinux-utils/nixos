{
  pkgs,
  lib,
  vars,
  ...
}:
with lib;

{
  config = mkIf (vars.modules.ollama.enable or false) {

    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      rocmOverrideGfx = "10.3.0"; # sets HSA_OVERRIDE_GFX_VERSION internally
      environmentVariables = {
        OLLAMA_FLASH_ATTENTION = "0";
        HIP_VISIBLE_DEVICES = "0";
      };
    };
    boot.initrd.kernelModules = [ "amdgpu" ];
  };

}
