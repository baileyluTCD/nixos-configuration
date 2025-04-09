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

    hyprland
  ];
  text = ''
    cd ${./src}

    exec Hyprland "$@" \
      --config "./hyprland.conf"
  '';
})
// {
  version = pkgs.hyprland.version;
}
