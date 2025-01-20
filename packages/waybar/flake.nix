{
  description = "Nix flake for a configured waybar derivation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-24.11";
    flake-utils.url = "github:numtide/flake-utils";

    hyprlock = {
      url = "git+file:///etc/nixos?dir=packages/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    hyprlock,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      name = "waybar";
      version = "1.0.0";

      hyprlock-configured = hyprlock.defaultPackage.${system};

      derivation = import ./default.nix {inherit hyprlock-configured pkgs name version;};
    in {
      defaultPackage = derivation;

      defaultApp = {
        type = "app";
        program = "${derivation}/bin/${name}";
      };
    });
}
