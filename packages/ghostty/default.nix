{ pkgs, ... }:
let
  config = pkgs.replaceVars ./config {
    shader = ./shader.glsl;
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
