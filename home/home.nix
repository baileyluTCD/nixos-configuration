{
  pkgs,
  nix-colors,
  wezterm-configured,
  nvim-configured,
  zsh-configured,
  nushell-configured,
  neovide-configured,
  ...
}: {
  home.username = "luke";
  home.homeDirectory = "/home/luke";
  home.stateVersion = "24.11";

  imports = [
    nix-colors.homeManagerModules.default

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
    docker
    wezterm-configured
    nvim-configured
    zsh-configured
    nushell-configured
    neovide-configured
  ];

  programs.home-manager.enable = true;
}
