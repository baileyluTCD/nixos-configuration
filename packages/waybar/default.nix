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

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${pkgs.waybar}/bin/waybar" $out/bin/${name} \
      --add-flags "--config $src/config.jsonc" \
      --add-flags "--style $src/style.css"
  '';
}
