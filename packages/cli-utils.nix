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
    eza

    unzip

    git
    glab
    gh
    lazygit

    pass

    direnv
    devenv

    podman

    carapace

    flake.packages.${system}.starship
    flake.packages.${system}.macchina
  ];
}
