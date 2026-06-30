{ pkgs, ... }:
{
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    completionInit = ''
      autoload -U compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
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
    initContent = ''
      # Ollama zsh completions
      #compdef ollama

      _ollama() {
        local curcontext="$curcontext" state line
        typeset -A opt_args
        local -a commands

        commands=(
          'serve:Start ollama'
          'create:Create a model from a Modelfile'
          'show:Show information for a model'
          'run:Run a model'
          'stop:Stop a running model'
          'pull:Pull a model from a registry'
          'push:Push a model to a registry'
          'list:List models'
          'ps:List running models'
          'cp:Copy a model'
          'rm:Remove a model'
          'help:Help about any command'
        )

        _arguments -C \
          '1: :->command' \
          '*:: :->args'

        case $state in
          (command)
            _describe -t commands 'ollama commands' commands
            ;;
          (args)
            case $line[1] in
              (run|pull|show|rm|cp|stop)
                local -a models
                models=(''${(f)"$(ollama list 2>/dev/null | tail -n +2 | awk '{print $1}')"})
                compadd -a models
                ;;
              (create)
                _arguments '-f[Specify Modelfile]:filename:_files'
                ;;
              (push)
                _arguments '1:model name' '2:destination'
                ;;
              (list|ps|serve)
                ;;
              (help)
                _describe -t commands 'ollama commands' commands
                ;;
            esac
            ;;
        esac
      }

      compdef _ollama ollama
    '';
  };
}
