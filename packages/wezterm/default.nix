{
  wezterm,
  nushell-configured,
  zsh-configured,
  pkgs,
  name,
  version,
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
    fira-code-nerdfont
    nushell-configured
    zsh-configured
  ];

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${wezterm}/bin/wezterm" $out/bin/${name} \
      --add-flags "--config-file $src/wezterm.lua"
  '';
}
