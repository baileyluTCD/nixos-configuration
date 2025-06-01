{
  pkgs,
  flake,
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
    ghostty
  ];
}
