{ pkgs, flake, ... }:
{
  imports = [ 
    flake.homeModules.luke
  ];

  home.packages = with pkgs; [
    flake.packages.${system}.desktop-apps
    flake.packages.${system}.cli-utils
    flake.packages.${system}.shells
    flake.packages.${system}.wayland-utils
    flake.packages.${system}.hyprlock
    flake.packages.${system}.neovim
  ];

}
