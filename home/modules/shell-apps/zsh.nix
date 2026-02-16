{ pkgs, ... }:
{

  home.packages = with pkgs; [
    lsd
    bat
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "lsd";
      l = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      lt = "ls --tree";
      cat = "bat";
    };
    plugins = [
      {
        name = "catlinux-zsh-theme";
        file = "catlinux.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "catlinux-utils";
          repo = "catlinux-zsh-theme";
          rev = "7bddeafc0f4ca713fb44ea84188f22ab5d1624eb";
          sha256 = "sha256-Q+3nX9qK2Ue7lhrTU0jeL2wE8sKkT8VdjRYUaOV9mcI=";
        };
      }
    ];
  };
}
