{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    neovide
  ];

  # You can also include other system-level configurations if needed
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = lib.fileContents ./src/init.lua;
  };
}
