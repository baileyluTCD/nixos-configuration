{
  pkgs,
  neovide-configured,
  zen-configured,
  ...
}: {
  home.username = "luke";
  home.stateVersion = "24.11";

  imports = [
    ./versionControl/default.nix
  ];

  home.packages = with pkgs; [
    bluetuith
    nerd-fonts.fira-code
    wl-clipboard
    fzf
    nurl
    btop
    lazygit
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
    neovide-configured
    zen-configured
    pass-wayland
  ];

  programs.home-manager.enable = true;
}
