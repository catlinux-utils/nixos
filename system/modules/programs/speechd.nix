{ lib, vars, ... }:
with lib;

{
  services.speechd = {
    enable = true;
  };

}
