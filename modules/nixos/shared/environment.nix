{
  flake,
  pkgs,
  ...
}:
{
  environment.sessionVariables = {
    EDITOR = "${flake.packages.${pkgs.system}.neovim}/bin/nvim";
  };
}
