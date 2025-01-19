{
  pkgs,
  name,
  version,
  starship-configured,
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
    zoxide
    fastfetch
    starship-configured
  ];

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${pkgs.zsh}/bin/zsh" $out/bin/${name} \
      --set OH_MY_ZSH_DIR "${pkgs.oh-my-zsh}" \
      --set ZDOTDIR $src
  '';
}
