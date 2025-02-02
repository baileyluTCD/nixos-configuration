{
  pkgs,
  name,
  version,
  hyprlock-configured,
  ...
}: let
  runtime-deps = with pkgs; [
    hyprlock-configured
    nerd-fonts.fira-code
    power-profiles-daemon
  ];
in
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
        --set WAYBAR_SRC "$src" \
        --add-flags "--config $src/config.jsonc" \
        --add-flags "--style $src/style.css" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';
  }
