{
  pkgs,
  name,
  version,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = name;
  version = version;

  src = ./config.rasi;

  phases = ["buildPhase"];

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    cp -r $src $out/bin

    makeWrapper "${pkgs.rofi-wayland}/bin/rofi" $out/bin/${name} \
      --add-flags "-dpi 125" \
      --add-flags "-config $src"
  '';
}
