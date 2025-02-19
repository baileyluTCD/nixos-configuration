{
  description = "Nix flake for a configured hyprland derivation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    wezterm = {
      url = "git+file:///etc/nixos?dir=packages/wezterm";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    neovide = {
      url = "git+file:///etc/nixos?dir=packages/neovide";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    hyprlock = {
      url = "git+file:///etc/nixos?dir=packages/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    hyprpaper = {
      url = "git+file:///etc/nixos?dir=packages/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    rofi = {
      url = "git+file:///etc/nixos?dir=packages/rofi";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    waybar = {
      url = "git+file:///etc/nixos?dir=packages/waybar";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    zen = {
      url = "git+file:///etc/nixos?dir=packages/zen";
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

      wezterm-configured = inputs.wezterm.defaultPackage.${system};
      neovide-configured = inputs.neovide.defaultPackage.${system};
      waybar-configured = inputs.waybar.defaultPackage.${system};
      hyprlock-configured = inputs.hyprlock.defaultPackage.${system};
      rofi-configured = inputs.rofi.defaultPackage.${system};
      hyprpaper-configured = inputs.hyprpaper.defaultPackage.${system};
      zen-configured = inputs.zen.defaultPackage.${system};

      overlay = import ./default.nix {
        inherit zen-configured hyprpaper-configured rofi-configured hyprlock-configured waybar-configured wezterm-configured neovide-configured pkgs;
      };

      overlaid-pkgs = pkgs.extend overlay;
    in {
      inherit overlay;

      defaultPackage = overlaid-pkgs.hyprland;

      defaultApp = {
        type = "app";
        program = "${overlaid-pkgs.hyprland}/bin/Hyprland";
      };
    });
}
