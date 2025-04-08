{
  pkgs,
  pname,
  flake,
  ...
}:
pkgs.stdenv.mkDerivation {
  inherit pname;
  version = "1.0.0";

  src = ./starship.toml;

  unpackPhase = ":";

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${pkgs.starship}/bin/starship" $out/bin/${pname} \
      --set STARSHIP_CONFIG $src
  '';
}
