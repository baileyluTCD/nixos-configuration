{ pkgs, flake, ... }: let
  theme = pkgs.replaceVars ./src/theme.scss (with flake.lib.colorScheme.palette; {
      foreground = base05;
      background = base00;
      line = base03;
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

  cfgDir = pkgs.runCommand "eww-config-dir" {} ''
    mkdir -p $out

    cp "${theme}" $out/theme.scss

    cp -r --update=none "${./src}/." $out
  '';
in
pkgs.writeShellApplication {
  name = "eww";
  runtimeInputs = [ pkgs.eww ];
  text = ''
    exec eww \
    --config "${cfgDir}" \
    "$@"
  '';
}
