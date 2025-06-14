{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "macchina";
  runtimeInputs = [ pkgs.macchina ];
  text = ''
    cd "${./src}"

    exec macchina \
      --config "${./src/Macchina.toml}" \
      --theme "${./src}/Nord" \
      "$@"
  '';
}
