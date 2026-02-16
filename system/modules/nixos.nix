{ inputs, vars, ... }:

{
  i18n.defaultLocale = "${vars.defaultLocale}";

  i18n.extraLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ALL = "${vars.defaultLocale}";
  };

  #security.polkit.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config = {
    allowUnfree = true; # Allow unfree packages
  };

  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];

  system.stateVersion = "26.05";

}
