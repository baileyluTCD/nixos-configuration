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

    cp -r $src $out/bin

    makeWrapper "${pkgs.hyprlock}/bin/hyprlock" $out/bin/${name} \
      --add-flags "--config $src/hyprlock.conf" \
      --set HYPRLOCK_BACKGROUND "$src/background.jpg"
  '';
}
