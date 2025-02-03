{
  description = "Nix flake for a configured wezterm derivation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    nushell = {
      url = "git+file:///etc/nixos?dir=packages/nushell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    zsh = {
      url = "git+file:///etc/nixos?dir=packages/zsh";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      name = "wezterm";
      version = "1.0.0";

      nushell-configured = inputs.nushell.defaultPackage.${system};
      zsh-configured = inputs.zsh.defaultPackage.${system};

      derivation = import ./default.nix {
        inherit nushell-configured zsh-configured pkgs name version;
      };
    in {
      defaultPackage = derivation;

      defaultApp = {
        type = "app";
        program = "${derivation}/bin/${name}";
      };
    });
}
