{
  description = "Home Manager configuration of luke";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nix-colors,
    hyprpanel,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        hyprpanel.overlay
      ];
    };

    preferences = import ./preferences.nix;
  in {
    hyprpanel = inputs.hyprpanel.overrideAttrs (oldAttrs: {
      installPhase = ''
        # Run the original install phase
        ${oldAttrs.installPhase}

        # Inject your local configuration files
        cp ./windowManager/hyprland/hyprpanel/hyprpanel_config.json $out/config.js
      '';
    });

    homeConfigurations."luke" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];
      extraSpecialArgs = {
        inherit nix-colors preferences system;
        inherit inputs;
      };
    };
  };
}
