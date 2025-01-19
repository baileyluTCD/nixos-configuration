{
  pkgs,
  name,
  version,
  starship-configured,
  ...
}: let
  runtime-deps = with pkgs; [
    zoxide
    fastfetch
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

    makeWrapper "${pkgs.zsh}/bin/zsh" $out/bin/${name} \
      --set OH_MY_ZSH_DIR "${pkgs.oh-my-zsh}" \
      --set ZDOTDIR $src
      --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps }
  '';
}
