{
  description = "Flake exposing home manager config for ghostty";

  inputs = {
    home-manager-shell.url = "github:dermetfan/home-manager-shell";
    home-manager.follows = "home-manager-shell/home-manager";
    flake-utils.follows = "home-manager-shell/flake-utils";

    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = {
    self,
    flake-utils,
    home-manager-shell,
    ghostty,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      apps.default = flake-utils.lib.mkApp {
        drv = home-manager-shell.lib {
          inherit self system;

          args.extraSpecialArgs = {
            ghostty = ghostty.packages.${system};
          };
        };
      };
    })
    // rec {
      modules = ./default.nix;
      homeManagerProfiles.luke = modules;
    };
}
