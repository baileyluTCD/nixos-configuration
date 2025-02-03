{
  description = "Nix flake for a configured zsh derivation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    macchina = {
      url = "git+file:///etc/nixos?dir=packages/macchina";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

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
    macchina,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      name = "zsh";
      version = "1.0.0";

      starship-configured = starship.defaultPackage.${system};
      macchina-configured = macchina.defaultPackage.${system};

      derivation = import ./default.nix {inherit macchina-configured starship-configured pkgs name version;};
    in {
      defaultPackage = derivation;

      defaultApp = {
        type = "app";
        program = "${derivation}/bin/${name}";
      };
    });
}
