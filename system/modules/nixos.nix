{ inputs, vars, ... }:

{
  i18n.defaultLocale = "${vars.defaultLocale}";

  i18n.extraLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "pl_PL.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ALL = "${vars.defaultLocale}";
  };
  services.xserver.xkb = {
    layout = "pl,us";
    variant = "";
  };

  #security.polkit.enable = true;
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true; # Allow unfree packages
    };
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
  };

  system.stateVersion = "26.05";

}
