{ pkgs, flake, ... }:
{
  imports = [ 
    flake.homeModules.luke
  ];

  home.packages = with pkgs; [
    flake.packages.${system}.desktop-apps
    flake.packages.${system}.cli-utils
    flake.packages.${system}.zsh
    flake.packages.${system}.neovim
  ];

}
