{
  pkgs,
  lib,
  vars,
  ...
}:
with lib;
{
  config = mkIf (vars.modules.ssh.enable or false) {

		services.openssh = {
			enable = true;
			settings ={
				PasswordAuthentication = true;
			};
		};
	};
}

