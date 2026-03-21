{
  pkgs,
  lib,
  vars,
  ...
}:
with lib;

{
  config = mkIf (vars.modules.ollama.enable or false) {

    environment.systemPackages = with pkgs; [
      nodejs_22
      cmake
      glibc
      glibc.dev
      gnumake
      ninja
      gcc
    ];

    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      rocmOverrideGfx = "10.3.0";
      environmentVariables = {
        OLLAMA_FLASH_ATTENTION = "0";
        HSA_OVERRIDE_GFX_VERSION = "10.3.0"; # helps ROCm recognize gfx1030
        HIP_VISIBLE_DEVICES = "0";

      };

    };
    boot.initrd.kernelModules = [ "amdgpu" ];
  };

}
