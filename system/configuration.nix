{
  pkgs,
  nvim-configured,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ./modules/networking.nix
    ./modules/locality.nix
    ./modules/sound.nix
    ./modules/graphics.nix
    ./modules/users.nix
    ./modules/startup.nix
    ./modules/laptop-config.nix
    ./modules/printing.nix
    ./modules/virtualization.nix
    ./modules/storage.nix
    ./modules/environment.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    unzip
    nvim-configured
  ];

  # The first version of nixos installed on this system
  # WARNING: This value should never be changed - see: `https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion`
  system.stateVersion = "24.05"; # Did you read the comment?
}
