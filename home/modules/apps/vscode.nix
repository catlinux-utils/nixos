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
        "password-store" = "gnome-libsecret";
      };
      profiles.default = {
        userSettings = {
          "update.mode" = "none";
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
          "update.showReleaseNotes" = false;
          "diffEditor.maxComputationTime" = 0;
          "editor.unicodeHighlight.ambiguousCharacters" = false;
          "diffEditor.hideUnchangedRegions.enabled" = true;

        };
        extensions =
          (with pkgs.vscode-marketplace; [
            ms-ceintl.vscode-language-pack-pl
            esbenp.prettier-vscode
            eamodio.gitlens
            donjayamanne.githistory
            mhutchie.git-graph

            bbenoist.nix
            jnoortheen.nix-ide

            theqtcompany.qt-core
            theqtcompany.qt-qml
          ])
          ++ (with pkgs.vscode-extensions; [
            github.copilot
            github.copilot-chat
          ]);
      };
    };
  };
}
