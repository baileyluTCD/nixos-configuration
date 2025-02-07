{
  pkgs,
  name,
  version,
  starship-configured,
  macchina-configured,
  ...
}: let
  runtime-deps = with pkgs; [
    zoxide
    macchina-configured
    starship-configured
    zsh-autosuggestions
    zsh-fast-syntax-highlighting
    zsh-autocomplete
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

      makeWrapper "${pkgs.zsh}/bin/zsh" $out/bin/${name} \
        --set ZSH "${pkgs.oh-my-zsh}/share/oh-my-zsh/oh-my-zsh.sh" \
        --set ZDOTDIR $src \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';

    passthru.shellPath = "/bin/zsh";
  }
