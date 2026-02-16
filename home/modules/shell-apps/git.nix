{ vars, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${vars.modules.home-manager.packages.git.name}";
        email = "${vars.modules.home-manager.packages.git.email}";
      };
      init.defaultBranch = "main";
    };
  };
}
