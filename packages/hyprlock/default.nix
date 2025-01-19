{
  pkgs,
  name,
  version,
  hyprpaper-configured,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = name;
  version = version;

  src = ./hyprlock.conf;

  phases = ["buildPhase"];

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    echo "${hyprpaper-configured}/bin/background.jpg"

    makeWrapper "${pkgs.hyprlock}/bin/hyprlock" $out/bin/${name} \
      --add-flags "--config $src" \
      --set HYPRLOCK_BACKGROUND "${hyprpaper-configured}/bin/background.jpg"
  '';
}
