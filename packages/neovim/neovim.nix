{
  config,
  pkgs,
  lib,
  ...
}: {
  # Load packages neovim depends on such as LSPs, etc
  home.packages = with pkgs; [
    neovide
  ];

  # Configure neovim from a file
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # Symlink the rest of the neovim config so that it can be accessed from the init.lua file
  home.file = {
    "nvim-config" = {
      source = ./src;
      target = ".config/nvim";
      recursive = true;
    };
  };
}
