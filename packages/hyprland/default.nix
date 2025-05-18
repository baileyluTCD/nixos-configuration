{
  pkgs,
  flake,
  ...
}:
(pkgs.writeShellApplication {
  name = "Hyprland";

  runtimeInputs = with pkgs; [
    flake.packages.${system}.desktop-apps
    flake.packages.${system}.wayland-utils

    flake.packages.${system}.hyprpaper
    flake.packages.${system}.hyprlock
    flake.packages.${system}.waybar

    nerd-fonts.fira-mono

    hyprland
  ];

  runtimeEnv.HYPRLAND_CONFIG = ./src/hyprland.conf;

  text = ''
    exec Hyprland "$@"
  '';
})
// {
  version = pkgs.hyprland.version;
}
