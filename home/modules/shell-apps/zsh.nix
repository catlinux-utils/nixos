{ pkgs, ... }:
{
  programs.command-not-found.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cat = "bat";
    };
    plugins = [
      {
        name = "catlinux-zsh-theme";
        file = "catlinux.zsh-theme";
        #nix-prefetch-github catlinux-utils catlinux-zsh-theme

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
