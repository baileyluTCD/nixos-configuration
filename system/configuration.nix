{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./locality.nix
    ./sound.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  services.upower.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luke = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    pciutils
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
    sddm
    hyprlock
    lm_sensors
  ];

  programs.hyprland.enable = true;
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
  };

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "luke";
      };
      default_session = initial_session;
    };
  };

  nix.settings.trusted-users = ["luke"];

  security.pam.services.hyprlock = {};

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # The first version of nixos installed on this system
  # WARNING: This value should never be changed - see: `https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion`
  system.stateVersion = "24.05"; # Did you read the comment?
}
