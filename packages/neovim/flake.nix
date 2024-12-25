{
  description = "Flake exposing home manager config for neovim";

  inputs = {
    # Switch to source once commit is merged
    home-manager-shell.url = "github:baileyluTCD/home-manager-shell";
    home-manager.follows = "home-manager-shell/home-manager";
    flake-utils.follows = "home-manager-shell/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    home-manager-shell,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      apps.default = flake-utils.lib.mkApp {
        drv = home-manager-shell.lib {
          inherit self system;
          # args.extraSpecialArgs.batStyle = "numbers";
        };
      };
    })
    // rec {
      modules = ./default.nix;
      homeManagerProfiles.luke = modules;
    };
}
