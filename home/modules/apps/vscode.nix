{
  lib,
  pkgs,
  vars,
  ...
}:

with lib;

{

  config = mkIf (vars.modules.desktop-environment.hyprland.enable or false) {

    programs.vscode = {
      enable = true;

      argvSettings = {
        "locale" = "pl";
        "enable-crash-reporter" = false;
        "crash-reporter-id" = "d68a8d55-43c4-4965-8ff3-66de9ea70427";

      };
      profiles.default = {
        userSettings = {
          "window.customTitleBarVisibility" = "auto";
          "window.titleBarStyle" = "custom";
          "workbench.activityBar.location" = "top";
          "terminal.integrated.fontFamily" = "MesloLGS Nerd Font";
          "telemetry.telemetryLevel" = "off";
          "explorer.confirmDragAndDrop" = false;
          "editor.formatOnSave" = true;
          "editor.formatOnPaste" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "git.confirmSync" = false;
          "git.suggestSmartCommit" = false;
          "workbench.sideBar.location" = "right";
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
          };
        };
        extensions = with pkgs.vscode-marketplace; [
          ms-ceintl.vscode-language-pack-pl
          esbenp.prettier-vscode
          eamodio.gitlens
          donjayamanne.githistory
          mhutchie.git-graph

          github.copilot
          github.copilot-chat

          bbenoist.nix
          jnoortheen.nix-ide

          theqtcompany.qt-core
          theqtcompany.qt-qml

        ];
      };
    };
  };
}
