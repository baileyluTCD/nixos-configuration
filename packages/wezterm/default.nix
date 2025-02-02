{
  wezterm,
  nushell-configured,
  zsh-configured,
  pkgs,
  name,
  version,
  ...
}: let
  runtime-deps = with pkgs; [
    nerd-fonts.fira-code
    nushell-configured
    zsh-configured
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

      makeWrapper "${wezterm}/bin/wezterm" $out/bin/${name} \
        --add-flags "--config-file $src/wezterm.lua" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';
  }
