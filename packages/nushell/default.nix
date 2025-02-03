{
  pkgs,
  name,
  version,
  starship-configured,
  ...
}: let
  runtime-deps = with pkgs; [
    zoxide
    bat
    macchina
    carapace
    starship-configured
  ];
in
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

      makeWrapper "${pkgs.nushell}/bin/nu" $out/bin/${name} \
        --add-flags "--config $src/config.nu" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';

    passthru.shellPath = "/bin/nu";
  }
