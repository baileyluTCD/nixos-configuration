{
  description = "Nix flake for a configured hyprlock derivation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    hyprpaper = {
      url = "git+file:///etc/nixos?dir=packages/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    hyprpaper,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      name = "hyprlock";
      version = "1.0.0";

      hyprpaper-configured = hyprpaper.defaultPackage.${system};

      derivation = import ./default.nix {
        inherit hyprpaper-configured pkgs name version;
      };
    in {
      defaultPackage = derivation;

      defaultApp = {
        type = "app";
        program = "${derivation}/bin/${name}";
      };
    });
}
