{
  pkgs,
  flake,
  perSystem,
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

    discord

    perSystem.zen-browser.default

    flake.packages.${system}.rofi
    flake.packages.${system}.foot
  ];
}
