{
  pkgs,
  pname,
  flake,
  ...
}: let
  runtime-deps = with pkgs; [
    zoxide
    bat
    carapace
    starship-configured
    macchina-configured
  ];
in
  pkgs.stdenv.mkDerivation {
    inherit pname;
    version = "1.0.0";

    src = ./src;

    # Inputs for wrapping program
    nativeBuildInputs = with pkgs; [
      makeWrapper
    ];

    buildPhase = ''
      mkdir -p $out/bin

      makeWrapper "${pkgs.nushell}/bin/nu" $out/bin/nu \
        --add-flags "--config $src/config.nu" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';

    passthru.shellPath = "/bin/nu";
  }
