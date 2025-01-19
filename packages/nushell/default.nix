{
  pkgs,
  name,
  version,
  starship-configured,
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
    zoxide
    git
    fastfetch
    carapace
    starship-configured
  ];

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${pkgs.nushell}/bin/nu" $out/bin/${name} \
      --add-flags "--config $src/config.nu"
  '';
}
