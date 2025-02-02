{
  description = "Root configuration flake importing both home-manager config and system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    system-config.url = "./system";
    home-manager.url = "./home";

    zsh = {
      url = "git+file:///etc/nixos?dir=packages/zsh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim = {
      url = "git+file:///etc/nixos?dir=packages/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+file:///etc/nixos?dir=packages/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    system-config,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    zsh-configured = inputs.zsh.defaultPackage.${system};
    nvim-configured = inputs.nvim.defaultPackage.${system};
    hyprland-configured = inputs.hyprland.defaultPackage.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = system;

      modules =
        system-config.modules
        ++ home-manager.modules
        ++ [
          ./global-config.nix
        ];

      specialArgs = {
        inherit hyprland-configured inputs zsh-configured nvim-configured;
      };
    };
  };
}
