{pkgs, ...}: {
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
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    lshw
    kitty
    clang-tools
    clang_multi
    gnumake
    nil
    alejandra
    zulu
    maven
    jdt-language-server
    rustup
    cargo
    rust-analyzer
    mold
    go
    elixir
    elixir-ls
    unzip
    lemminx
    lm_sensors
  ];

  # The first version of nixos installed on this system
  # WARNING: This value should never be changed - see: `https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion`
  system.stateVersion = "24.05"; # Did you read the comment?
}
