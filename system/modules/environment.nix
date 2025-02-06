{nvim-configured, ...}: {
  environment.sessionVariables = {
    EDITOR = "${nvim-configured}/bin/nvim";
  };
}
