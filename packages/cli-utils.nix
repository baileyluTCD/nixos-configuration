{
  pkgs,
  flake,
  system,
  ...
}:
pkgs.symlinkJoin {
  name = "cli-utils";

  paths = with pkgs; [
    zoxide
    bat
    fzf
    btop

    glab
    gh
    lazygit

    nurl
    direnv
    devenv

    podman

    carapace

    flake.packages.${system}.starship
    flake.packages.${system}.macchina
  ];
}
