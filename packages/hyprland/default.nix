{
  pkgs,
  name,
  version,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = name;
  version = version;

  src = ./src;

  # Inputs for wrapping hyprland
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  # Runtime inputs
  buildInputs = with pkgs; [
    firefox
    grim
    slurp
    wireplumber

    # TODO: source from actual config
    wezterm
    rofi
    neovide
    hyprlock
    waybar
  ];

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${pkgs.hyprland}/bin/Hyprland" $out/bin/${name} \
      --add-flags "--config $src/hyprland.conf"
  '';

  installPhase = ''
    cp -r $src $out/bin/src
  '';
}
