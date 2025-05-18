{
  pkgs,
  flake,
  ...
}: {
  imports = [
    ./caches.nix
    ./environment.nix
    ./locality.nix
    ./networking.nix
    ./printing.nix
    ./secrets.nix
    ./startup.nix
    ./virtualisation.nix
  ];

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.nix-ld.enable = true;

  # List packages installed in system profile. To search, run: $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    flake.packages.${system}.shells
  ];
}
