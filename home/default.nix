{
  pkgs,
  hyprland-configured,
  neovide-configured,
  ...
}: {
  home.username = "luke";
  home.homeDirectory = "/home/luke";
  home.stateVersion = "24.11";

  imports = [
    ./versionControl/default.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    fzf
    btop
    dust
    obsidian
    pavucontrol
    pinta
    gnome-bluetooth
    glab
    devenv
    direnv
    zoxide
    vscode
    discord
    podman
    hyprland-configured
    neovide-configured
  ];

  programs.home-manager.enable = true;
}
