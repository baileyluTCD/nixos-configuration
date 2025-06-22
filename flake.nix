{
  description = "Root configuration flake importing both home-manager config and system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default-linux";

    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";
    blueprint.inputs.systems.follows = "systems";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    ironbar.url = "github:JakeStanger/ironbar";
    ironbar.inputs.nixpkgs.follows = "nixpkgs";
    ironbar.inputs.nix-systems.follows = "systems";

    naersk.url = "github:nix-community/naersk";
    naersk.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.blueprint {
      inherit inputs;
      nixpkgs.config.allowUnfree = true;
    };
}
