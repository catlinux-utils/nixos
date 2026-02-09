{ vars, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${vars.packages.git.name}";
        email = "${vars.packages.git.email}";
      };
      init.defaultBranch = "main";
    };
  };
}
