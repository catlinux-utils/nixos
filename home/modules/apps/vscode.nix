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
        extensions = [
          pkgs.vscode-marketplace.ms-ceintl.vscode-language-pack-pl
          pkgs.vscode-marketplace.bbenoist.nix
          pkgs.vscode-marketplace.jnoortheen.nix-ide
          pkgs.vscode-marketplace.esbenp.prettier-vscode

          pkgs.vscode-marketplace.theqtcompany.qt-core
          pkgs.vscode-marketplace.theqtcompany.qt-qml

        ];
      };
    };
  };
}
