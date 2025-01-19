{
  description = "Nix flake for a configured hyprland derivation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-24.11";
    flake-utils.url = "github:numtide/flake-utils";

    waybar = {
      url = "git+file:///etc/nixos?dir=packages/waybar";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    wezterm = {
      url = "git+file:///etc/nixos?dir=packages/wezterm";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    nvim = {
      url = "git+file:///etc/nixos?dir=packages/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    hyprlock = {
      url = "git+file:///etc/nixos?dir=packages/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    rofi = {
      url = "git+file:///etc/nixos?dir=packages/rofi";
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

      name = "Hyprland";
      version = "1.0.0";

      wezterm-configured = inputs.wezterm.defaultPackage.${system};
      nvim-configured = inputs.nvim.defaultPackage.${system};
      waybar-configured = inputs.waybar.defaultPackage.${system};
      hyprlock-configured = inputs.hyprlock.defaultPackage.${system};
      rofi-configured = inputs.rofi.defaultPackage.${system};

      derivation = import ./default.nix {
        inherit rofi-configured hyprlock-configured waybar-configured wezterm-configured nvim-configured pkgs name version;
      };
    in {
      defaultPackage = derivation;

      defaultApp = {
        type = "app";
        program = "${derivation}/bin/${name}";
      };
    });
}
