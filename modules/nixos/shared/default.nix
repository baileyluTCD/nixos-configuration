{
  pkgs,
  flake,
  inputs,
  ...
}:
{
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
    ./caches.nix
    ./environment.nix
    ./locality.nix
    ./networking.nix
    ./printing.nix
    ./startup.nix
    ./virtualisation.nix
  ];

  # Enable flakes
  nix = {
    package = pkgs.lix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # List packages installed in system profile. To search, run: $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    flake.packages.${system}.zsh
    nh
  ];

  programs.nix-index-database.comma.enable = true;
}
