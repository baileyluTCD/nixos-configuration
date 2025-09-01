{ pkgs, flake, inputs, ... }:
let
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
in

{
  imports = [
    flake.homeModules.luke
    inputs.nix-colors.homeManagerModules.default
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
      name = "${flake.lib.colorScheme.slug}";
      package = gtkThemeFromScheme {scheme = flake.lib.colorScheme;};
    };
    font = {
      name = "Adwaita";
      package = pkgs.adwaita-fonts;
    };
  };
}
