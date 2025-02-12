{
  pkgs,
  name,
  version,
  ...
}: let
  runtime-deps = with pkgs; [
    wl-clipboard
    rofi-obsidian
  ];
in
  pkgs.stdenv.mkDerivation {
    name = name;
    version = version;

    src = ./config.rasi;

    phases = ["buildPhase"];

    # Inputs for wrapping program
    nativeBuildInputs = with pkgs; [
      makeWrapper
    ];

    buildPhase = ''
      mkdir -p $out/bin

      cp -r $src $out/bin

      makeWrapper "${pkgs.rofi-wayland}/bin/rofi" $out/bin/${name} \
        --add-flags "-dpi 130" \
        --add-flags "-config $src" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';
  }
