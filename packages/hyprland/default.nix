{
  pkgs,
  name,
  version,
  hyprlock-configured,
  hyprpaper-configured,
  neovide-configured,
  rofi-configured,
  waybar-configured,
  wezterm-configured,
  ...
}: let
  runtime-deps = with pkgs; [
    firefox
    grim
    slurp
    wireplumber
    hyprlock-configured
    hyprpaper-configured
    neovide-configured
    rofi-configured
    waybar-configured
    wezterm-configured
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
        --add-flags "--config $src/hyprland.conf" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';
  }
