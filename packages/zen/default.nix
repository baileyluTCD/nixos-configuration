{
  pkgs,
  name,
  version,
  zen-browser,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = name;
  version = version;

  src = ./src;

  phases = ["buildPhase"];

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    cp -r $src $out/bin

    makeWrapper "${zen-browser}/bin/zen" $out/bin/${name}
  '';
}
