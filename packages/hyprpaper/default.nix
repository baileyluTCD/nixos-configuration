{
  pkgs,
  pname,
  ...
}:
pkgs.stdenv.mkDerivation {
  inherit pname;
  version = "1.0.0";

  src = ./src;

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    cp -r $src/* $out/bin

    makeWrapper "${pkgs.hyprpaper}/bin/hyprpaper" $out/bin/${pname} \
      --add-flags "--config $out/bin/hyprpaper.conf" \
      --set HYPRPAPER_BACKGROUND "$out/bin/background.jpg"
  '';
}
