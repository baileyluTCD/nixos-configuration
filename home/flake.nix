{
  description = "Flake containing home manager configurations";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    flake-utils.url = "github:numtide/flake-utils";

    nvim = {
      url = "git+file:///etc/nixos?dir=packages/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm = {
      url = "git+file:///etc/nixos?dir=packages/wezterm";
      inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = inputs @ {
    flake-utils,
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
    modules = [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.luke = {
          imports = [
            ./home.nix
          ];
        };

        home-manager.extraSpecialArgs = {
          inherit pkgs;
          inherit nix-colors preferences system;
          inherit inputs;

          nvim-configured = inputs.nvim.defaultPackage.${system};
          wezterm-configured = inputs.wezterm.defaultPackage.${system};
          nushell-configured = inputs.nushell.defaultPackage.${system};
          zsh-configured = inputs.zsh.defaultPackage.${system};
        };
      }
    ];
  };
}
