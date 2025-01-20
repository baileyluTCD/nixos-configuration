{
  pkgs,
  nix-colors,
  hyprland-configured,
  neovide-configured,
  ...
}: {
  home.username = "luke";
  home.homeDirectory = "/home/luke";
  home.stateVersion = "24.11";

  imports = [
    nix-colors.homeManagerModules.default

    ./versionControl/default.nix
  ];

  colorScheme = nix-colors.colorSchemes.horizon-dark;

  home.packages = with pkgs; [
    nerdfonts
    wl-clipboard
    font-awesome
    fzf
    obsidian
    pavucontrol
    gimp
    broot
    basex
    clangMultiStdenv
    bat
    gnome-bluetooth
    zip
    glab
    devenv
    direnv
    zoxide
    libreoffice
    vscode
    discord
    docker
    hyprland-configured
    neovide-configured
  ];

  programs.home-manager.enable = true;
}
