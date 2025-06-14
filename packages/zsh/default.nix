{
  pkgs,
  flake,
  system,
  ...
}:
let
  plugins = pkgs.symlinkJoin {
    name = "zsh-plugins";

    paths = with pkgs; [
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-autocomplete
      zsh-vi-mode
    ];
  };
in
pkgs.writeShellApplication {
  name = "zsh";

  runtimeInputs = with pkgs; [
    zsh
    flake.packages.${system}.cli-utils
  ];

  runtimeEnv = {
    ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh/";
    ZDOTDIR = "${./src}";
    ZSH_PLUGINS = "${plugins}/share";
  };

  text = ''
    exec zsh "$@"
  '';

  passthru.shellPath = "/bin/zsh";
}
