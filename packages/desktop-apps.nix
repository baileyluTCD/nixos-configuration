{
  pkgs,
  flake,
  system,
  ...
}:
pkgs.symlinkJoin {
  name = "desktop-apps";

  paths = with pkgs; [
    brightnessctl
    pavucontrol

    xdg-desktop-portal-gnome
    nautilus

    obsidian

    pinta

    goofcord

    librewolf-wayland
    flake.packages.${system}.ghostty
    flake.packages.${system}.hyprlock
  ];
}
