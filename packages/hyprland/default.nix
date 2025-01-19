{
  pkgs,
  name,
  version,
  wezterm-configured,
  nvim-configured,
  ...
}: let
  runtime-deps = with pkgs; [
    firefox
    grim
    slurp
    wireplumber
    wezterm-configured
    waybar-configured
    nvim-configured

    # TODO: source from actual config
    rofi
    hyprlock
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

      makeWrapper "${pkgs.hyprland}/bin/Hyprland" $out/bin/${name} \
        --add-flags "--config $src/hyprland.conf"
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';
  }
