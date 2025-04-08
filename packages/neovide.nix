{
  pkgs,
  pname,
  flake,
  ...
}: let
  runtime-deps = with pkgs; [
    nerd-fonts.fira-code
  ];
in
  pkgs.stdenv.mkDerivation {
    inherit pname;
    version = "1.0.0";

    nativeBuildInputs = with pkgs; [
      makeWrapper
    ];

    buildPhase = ''
      mkdir -p $out/bin

      makeWrapper "${pkgs.neovide}/bin/neovide" $out/bin/${pname} \
        --add-flags "--neovim-bin '${flake.neovim}/bin/nvim'" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';

    installPhase = ''
      cp -r ${pkgs.neovide}/share $out
    '';
  }
