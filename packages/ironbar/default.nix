{ pkgs, inputs, ... }:
let
  features = ["config+toml" "workspaces+niri" "upower" "clock" "focused" "volume"];
  naersk = pkgs.callPackage inputs.naersk {};
  ironbar = pkgs.callPackage (inputs.ironbar + "/nix/package.nix") { inherit features naersk; };
in
pkgs.writeShellApplication {
  name = "ironbar";
  runtimeInputs = [ ironbar ];
  runtimeEnv = {
    IRONBAR_CONFIG = ./config.toml;
    IRONBAR_CSS = ./style.css;
  };
  text = ''
    exec ironbar "$@"
  '';
}
