{ vars, ...}:

{
	services.openssh = {
		enable = true;
		settings ={
			PasswordAuthentication = true;
		};
	};

}

