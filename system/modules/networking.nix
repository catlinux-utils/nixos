{ vars, ... }:
{
  networking.hostName = "${vars.networkingHostName}";
  networking.networkmanager.enable = true;

}
