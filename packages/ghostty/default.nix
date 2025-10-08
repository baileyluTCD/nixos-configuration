{ pkgs, flake, ... }:
let
  config = pkgs.replaceVars ./config {
    shader = ./shader.glsl;
    background = flake.lib.colorScheme.palette.base00;
  };
in
pkgs.writeShellApplication {
  name = "ghostty";
  runtimeInputs = [ pkgs.ghostty ];
  text = ''
    exec ghostty \
      --config-file="${config}" \
      "$@"
  '';
}
