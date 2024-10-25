{
  pkgs,
  nix-colors,
  ...
}: {
  home.username = "luke";
  home.homeDirectory = "/home/luke";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  imports = [
    nix-colors.homeManagerModules.default

    ./hyprland.nix

    ./shell/default.nix
    ./terminal/default.nix
    ./versionControl/default.nix
    ./browser/default.nix
    ./editor/default.nix
  ];

  colorScheme = nix-colors.colorSchemes.horizon-dark;

  home.packages = with pkgs; [
    waybar
    wofi
    nerdfonts
    font-awesome
    wl-clipboard
    neofetch
    fzf
    obsidian
  ];

  programs.home-manager.enable = true;
}
