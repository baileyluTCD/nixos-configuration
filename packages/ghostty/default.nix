{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "ghostty";
  runtimeInputs = [ pkgs.ghostty ];
  text = ''
    exec ghostty \
      --config-file="${./config}" \
      "$@"
  '';
}
