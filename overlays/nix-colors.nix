final: prev: let
  nixColors = import (fetchTarball "https://github.com/rschiang/nix-colors/archive/refs/heads/main.tar.gz") {inherit (prev) lib;};
in {
  nix-colors = nixColors;
}
