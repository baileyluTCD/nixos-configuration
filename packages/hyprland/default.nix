{
  pkgs,
  name,
  version,
  wezterm-configured,
  nvim-configured,
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

  # Runtime inputs
  buildInputs = with pkgs; [
    firefox
    grim
    slurp
    wireplumber
    wezterm-configured
    nvim-configured

    # TODO: source from actual config
    rofi
    hyprlock
    waybar
  ];

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${pkgs.hyprland}/bin/Hyprland" $out/bin/${name} \
      --add-flags "--config $src/hyprland.conf"
  '';
}
