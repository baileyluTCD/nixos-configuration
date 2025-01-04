{
  description = "Flake exposing home manager config for wezterm";

  inputs = {
    home-manager-shell.url = "github:dermetfan/home-manager-shell";
    home-manager.follows = "home-manager-shell/home-manager";
    flake-utils.follows = "home-manager-shell/flake-utils";

    nushell.url = "/etc/nixos/packages/nushell";

    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = {
    self,
    flake-utils,
    home-manager-shell,
    nushell,
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
      modules = {
        imports = [
          nushell.modules
          ./default.nix
        ];
      };
      homeManagerProfiles.luke = modules;
    };
}
