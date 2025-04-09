{
  pkgs,
  flake,
  ...
}: {
  imports = [
    ./environment.nix
    ./locality.nix
    ./networking.nix
    ./printing.nix
    ./startup.nix
  ];

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List packages installed in system profile. To search, run: $ nix search nixpkgs wget
  environment.systemPackages = with pkgs; [
    flake.packages.${system}.shells
  ];
}
