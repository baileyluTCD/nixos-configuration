{ pkgs, flake, ... }: let
  theme = pkgs.replaceVars ./theme (with flake.lib.colorScheme.palette; {
    base00 = base00;
    base02 = base02;
    base03 = base03;
    base05 = base05;
    base07 = base07;
    base08 = base08;
    base0A = base0A;
    base0B = base0B;
    base0C = base0C;
    base0D = base0D;
    base0E = base0E;
    base0F = base0F;
  });

  config = pkgs.replaceVars ./config {
    theme = theme;
  };
in
pkgs.writeShellApplication {
  name = "ghostty";
  runtimeInputs = [ pkgs.ghostty ];
  text = ''
    cat ${config}

    exec ghostty \
      --config-file="${config}" \
      "$@"
  '';
}
