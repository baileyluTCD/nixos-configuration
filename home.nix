{ config, pkgs, nix-colors, ... }:

{
  home.username = "luke";
  home.homeDirectory = "/home/luke";
  home.stateVersion = "24.05"; 

  imports = [
    nix-colors.homeManagerModules.default

    ./hyprland.nix
    ./shell/nushell.nix
  ];

  colorScheme = nix-colors.colorSchemes.nord;

  programs.git = {
    enable = true;
    userName = "Luke Bailey";
    userEmail = "baileylu@tcd.ie";
  };

  programs.gh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.firefox.enable = true;
  programs.kitty = {
    enable = true;
    settings = {
      shell = "nu";
    };
  };

  home.packages = with pkgs; [
    waybar
    wofi
    nerdfonts
    font-awesome
    wl-clipboard
  ];

  home.file = {
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.home-manager.enable = true;
}
