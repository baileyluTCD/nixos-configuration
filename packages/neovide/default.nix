{
  pkgs,
  name,
  version,
  nvim-configured,
  ...
}: let
  runtime-deps = with pkgs; [
    nerd-fonts.fira-code
  ];
in
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
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';

    installPhase = ''
      cp -r ${pkgs.neovide}/share $out
    '';
  }
