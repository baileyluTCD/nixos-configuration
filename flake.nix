{
  description = "Root configuration flake importing both home-manager config and system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    system-config.url = "./system";
    home-manager.url = "./home";
  };

  outputs = {
    self,
    nixpkgs,
    system-config,
    home-manager,
  }: let
    target = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = target;

      modules =
        system-config.modules
        ++ home-manager.modules
        ++ [
          ./global-config.nix
        ];
    };
  };
}
