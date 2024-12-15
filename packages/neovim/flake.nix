{
  description = "Nix flake managing neovim and dependencies such as language servers";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            neovim
            neovide
          ];
        };

        apps.default = {
          type = "app";
          program = "${pkgs.neovide}/bin/neovide";
        };
      }
    );
}
