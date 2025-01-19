{
  description = "Nix flake for a configured wezterm derivation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-24.11";
    flake-utils.url = "github:numtide/flake-utils";

    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    nushell = {
      url = "git+file:///etc/nixos?dir=packages/nushell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    zsh = {
      url = "git+file:///etc/nixos?dir=packages/nushell";
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

      wezterm = inputs.wezterm.packages.${system}.default;

      nushell-configured = inputs.nushell.defaultPackage.${system};
      zsh-configured = inputs.zsh.defaultPackage.${system};

      derivation = import ./default.nix {
        inherit wezterm nushell-configured zsh-configured pkgs name version;
      };
    in {
      defaultPackage = derivation;

      defaultApp = {
        type = "app";
        program = "${derivation}/bin/${name}";
      };
    });
}
