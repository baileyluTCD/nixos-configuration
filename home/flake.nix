{
  description = "Flake containing home manager configurations";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    hyprland = {
      url = "git+file:///etc/nixos?dir=packages/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.neovide.follows = "neovide";
    };

    neovide = {
      url = "git+file:///etc/nixos?dir=packages/neovide";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-utils,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;
    };
  in {
    modules = [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.luke = {
          imports = [
            ./default.nix
          ];
        };

        home-manager.extraSpecialArgs = {
          inherit pkgs system inputs;

          hyprland-configured = inputs.hyprland.defaultPackage.${system};
          neovide-configured = inputs.neovide.defaultPackage.${system};
        };
      }
    ];
  };
}
