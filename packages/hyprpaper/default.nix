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

    cp -r $src/* $out/bin

    makeWrapper "${pkgs.hyprpaper}/bin/hyprpaper" $out/bin/${name} \
      --add-flags "--config $out/bin/hyprpaper.conf" \
      --set HYPRPAPER_BACKGROUND "$out/bin/background.jpg"
  '';
}
