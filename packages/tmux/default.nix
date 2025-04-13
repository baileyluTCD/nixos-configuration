{pkgs, flake, ...}: let
  plugins = pkgs.symlinkJoin {
    name = "tmux-plugins";

    paths = with pkgs.tmuxPlugins; [
      gruvbox
      sensible
      tmux-fzf
      vim-tmux-navigator
    ];
  };
in
pkgs.writeShellApplication {
  name = "tmux";
  runtimeEnv = {
    TMUX_PLUGIN_DIR = "${plugins}/share/tmux-plugins";
    SHELL = "${flake.packages.${pkgs.system}.nushell}/bin/nu";
  };
  runtimeInputs = with pkgs; [
    tmux
    fzf
    python3
  ];
  text = ''
    exec tmux "$@" \
      -f ${./tmux.conf}
  '';
}
