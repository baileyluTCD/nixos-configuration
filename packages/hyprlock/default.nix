{
  pkgs,
  pname,
  flake,
  ...
}:
pkgs.stdenv.mkDerivation {
  inherit pname;
  version = "1.0.0";

  src = ./hyprlock.conf;

  phases = ["buildPhase"];

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    echo "${flake.hyprpaper}/bin/background.jpg"

    makeWrapper "${pkgs.hyprlock}/bin/hyprlock" $out/bin/${pname} \
      --add-flags "--config $src" \
      --set HYPRLOCK_BACKGROUND "${flake.hyprpaper}/bin/background.jpg"
  '';
}
