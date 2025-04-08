{
  pkgs,
  flake,
  system,
  ...
}:
pkgs.symlinkJoin {
  name = "shells";

  paths = [
    flake.packages.${system}.nushell
    flake.packages.${system}.zsh
  ];
}
