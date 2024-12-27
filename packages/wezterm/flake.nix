{
  description = "Flake exposing home manager config for wezterm";

  inputs = {
    # Switch to source once commit is merged
    home-manager-shell.url = "github:baileyluTCD/home-manager-shell";
    home-manager.follows = "home-manager-shell/home-manager";
    flake-utils.follows = "home-manager-shell/flake-utils";

    wezterm.url = "github:wez/wezterm?dir=nix";
    wezterm-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    flake-utils,
    home-manager-shell,
    wezterm,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: {
      apps.default = flake-utils.lib.mkApp {
        drv = home-manager-shell.lib {
          inherit self system;

          args.extraSpecialArgs = {
            wezterm = wezterm.packages.${system};
          };
        };
      };
    })
    // rec {
      modules = ./default.nix;
      homeManagerProfiles.luke = modules;
    };
}
