{
  description = "Flake containing home manager configurations";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    nvim.url = "/etc/nixos/packages/neovim";
    wezterm.url = "/etc/nixos/packages/wezterm";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nix-colors,
    hyprpanel,
    nvim,
    wezterm,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      overlays = [
        hyprpanel.overlay
      ];

      config.allowUnfree = true;
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

    modules = [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.luke = {
          imports = [
            nvim.modules
            wezterm.modules
            ./home.nix
          ];
        };

        home-manager.extraSpecialArgs = {
          inherit pkgs;
          inherit nix-colors preferences system;
          inherit inputs;
        };
      }
    ];
  };
}
