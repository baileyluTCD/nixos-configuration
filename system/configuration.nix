{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./locality.nix
    ./sound.nix
    ./graphics.nix
    ./users.nix
    ./startup.nix
    ./laptop-config.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # The first version of nixos installed on this system
  # WARNING: This value should never be changed - see: `https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion`
  system.stateVersion = "24.05"; # Did you read the comment?
}
