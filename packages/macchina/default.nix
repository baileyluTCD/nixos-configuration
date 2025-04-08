{
  pkgs,
  pname,
  ...
}:
pkgs.stdenv.mkDerivation {
  inherit pname;
  version = "1.0.0";

  src = ./src;

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    {
      cat $src/Gruvbox.toml;
      printf "\n[custom_ascii]\npath = '$src/NixLogo.txt'\ncolor='#d5c4a1'\n";
    } > $out/Gruvbox.toml

    makeWrapper "${pkgs.macchina}/bin/macchina" $out/bin/${pname} \
      --add-flags "--config $src/Macchina.toml" \
      --add-flags "--theme $out/Gruvbox"
  '';
}
