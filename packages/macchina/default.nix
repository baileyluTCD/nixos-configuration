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

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    { 
      cat $src/Gruvbox.toml;
      printf "\n[custom_ascii]\npath = '$src/NixLogo.txt'\ncolor='#d5c4a1'\n"; 
    } > $out/Gruvbox.toml

    makeWrapper "${pkgs.macchina}/bin/macchina" $out/bin/${name} \
      --add-flags "--config $src/Macchina.toml" \
      --add-flags "--theme $out/Gruvbox"
    '';
}
