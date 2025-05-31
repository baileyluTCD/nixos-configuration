{flake, ...}: {
  imports = [
    ./hardware-configuration.nix

    flake.nixosModules.niri-system
    flake.nixosModules.user-luke

    flake.nixosModules.laptop-config
    flake.nixosModules.nvidia-graphics
    flake.nixosModules.pipewire-sound
  ];

  # The first version of nixos installed on this system
  # WARNING: This value should never be changed - see: `https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion`
  system.stateVersion = "24.05"; # Did you read the comment?
}
