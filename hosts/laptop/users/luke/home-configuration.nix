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

    nerd-fonts.adwaita-mono
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy-dark";
      package = pkgs.nordzy-icon-theme;
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
    };
    font = {
      name = "Adwaita";
      package = pkgs.adwaita-fonts;
    };
  };
}
