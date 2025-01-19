{
  pkgs,
  name,
  version,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = name;
  version = version;

  src = ./src;

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  # Runtime inputs
  buildInputs = with pkgs; [
    fira-code-nerdfont
    power-profiles-daemon
  ];

  buildPhase = ''
    mkdir -p $out/bin

    export WAYBAR_DIR="$out/bin"

    makeWrapper "${pkgs.waybar}/bin/waybar" $out/bin/${name} \
      --add-flags "--config $WAYBAR_DIR/config.jsonc" \
      --add-flags "--style $WAYBAR_DIR/style.css"
  '';

  installPhase = ''
    cp -r $src/* $WAYBAR_DIR
  '';
}
