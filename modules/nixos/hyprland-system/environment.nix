{flake, system, ...}: {
  environment.sessionVariables = {
    EDITOR = "${flake.packages.${system}.neovim}/bin/nvim";
  };
}
