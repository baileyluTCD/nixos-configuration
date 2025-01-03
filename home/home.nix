{
  pkgs,
  nix-colors,
  ...
}: {
  home.username = "luke";
  home.homeDirectory = "/home/luke";
  home.stateVersion = "24.11";

  imports = [
    nix-colors.homeManagerModules.default

    ./shell/default.nix
    ./terminal/default.nix
    ./versionControl/default.nix
    ./browser/default.nix
    ./windowManager/default.nix
  ];

  colorScheme = nix-colors.colorSchemes.horizon-dark;

  home.packages = with pkgs; [
    nerdfonts
    font-awesome
    wl-clipboard
    neofetch
    fzf
    obsidian
    pavucontrol
    gimp
    broot
    basex
    clangMultiStdenv
    grim
    slurp
    bat
    gnome-bluetooth
    hyprpanel
    zip
    glab
    devenv
    zoxide
    libreoffice
    vscode
    discord
  ];

  programs.home-manager.enable = true;
}
