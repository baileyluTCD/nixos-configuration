{
  pkgs,
  name,
  version,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = name;
  version = version;

  src = ./starship.toml;

  unpackPhase = ":";

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${pkgs.starship}/bin/starship" $out/bin/${name} \
      --set STARSHIP_CONFIG $src
    '';
}
