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
      (final: prev: {
        rimsort = prev.rimsort.overrideAttrs (oldAttrs: rec {
          version = "1.0.76";

          # nix-prefetch-git --fetch-submodules "https://github.com/RimSort/RimSort" --rev v1.0.76

          src = prev.fetchFromGitHub {
            owner = "RimSort";
            repo = "RimSort";
            rev = "v${version}";
            hash = "sha256-EO1j4GPRQSB+QEF4tB87x4nCUKpdWU9aGlDFghwxar0=";
            fetchSubmodules = true;
          };
        });
      })
    ];
  };

  system.stateVersion = "26.05";

}
