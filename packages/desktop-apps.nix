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

    goofcord
    fractal

    perSystem.zen-browser.default

    wine

    flake.packages.${system}.rofi
    flake.packages.${system}.foot
  ];
}
