{
  pkgs,
  pname,
  flake,
  ...
}: let
  runtime-deps = with pkgs; [
    nerd-fonts.fira-code
    flake.nushell
    flake.zsh
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

      makeWrapper "${pkgs.wezterm}/bin/wezterm" $out/bin/wezterm \
        --add-flags "--config-file $src/wezterm.lua" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';
  }
