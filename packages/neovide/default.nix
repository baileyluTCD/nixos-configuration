{
  pkgs,
  name,
  version,
  nvim-configured,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = name;
  version = version;

  phases = ["buildPhase" "installPhase"];

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${pkgs.neovide}/bin/${name}" $out/bin/${name} \
      --add-flags "--neovim-bin '${nvim-configured}/bin/nvim'" \
  '';

  installPhase = ''
    cp -r ${pkgs.neovide}/share $out
  '';
}
