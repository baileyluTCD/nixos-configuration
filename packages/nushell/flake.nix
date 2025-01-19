{
  description = "Nix flake for a configured nushell derivation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-24.11";
    flake-utils.url = "github:numtide/flake-utils";

    starship = {
      url = "git+file:///etc/nixos?dir=packages/starship";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    starship,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      name = "nu";
      version = "1.0.0";

      starship-configured = starship.defaultPackage.${system};

      derivation = import ./default.nix {inherit starship-configured pkgs name version;};
    in {
      defaultPackage = derivation;

      defaultApp = {
        type = "app";
        program = "${derivation}/bin/${name}";
      };
    });
}
