{ pkgs, flake, ... }: let
  config = pkgs.replaceVars ./starship.toml (with flake.lib.colorScheme.palette; {
      foreground = base05;
      background = base00;
      current_line = base01;
      primary = base00;
      box = base01;
      blue = base0D;
      cyan = base0C;
      green = base0B;
      orange = base09;
      pink = base0E;
      purple = base0E;
      red = base08;
      yellow = base0A;
  });
in
pkgs.writeShellApplication {
  name = "starship";
  runtimeInputs = [ pkgs.starship ];
  runtimeEnv.STARSHIP_CONFIG = config;
  text = ''
    exec starship "$@"
  '';
}
