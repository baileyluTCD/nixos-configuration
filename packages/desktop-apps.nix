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

    neovide
    obsidian

    pinta

    goofcord

    librewolf-wayland
    flake.packages.${system}.ghostty
  ];
}
