{
  pkgs,
  pname,
  flake,
  ...
}: let
  runtime-deps = with pkgs; [
    flake.hyprlock
    nerd-fonts.fira-code
    power-profiles-daemon
  ];
in
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

      makeWrapper "${pkgs.waybar}/bin/waybar" $out/bin/waybar \
        --set WAYBAR_SRC "$src" \
        --add-flags "--config $src/config.jsonc" \
        --add-flags "--style $src/style.css" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';
  }
