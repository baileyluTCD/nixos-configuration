{
  description = "Root configuration flake importing both home-manager config and system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    system-config.url = "./system";
  };

  outputs = {
    self,
    nixpkgs,
    system-config,
  }: let
    target = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = target;

      modules = system-config.modules;
    };
  };
}
