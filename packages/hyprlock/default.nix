{ pkgs, flake, ... }:
let
  config = pkgs.replaceVars ./hyprlock.conf (
    with flake.lib.colorScheme.palette;
    {
      backgroundImage = ../../modules/nixos/niri-system/desktopBackgroundBlurred.png;

      timeColor = base07;
      textColor = base05;
      boxColor = base00 + "96";
    }
  );
in
pkgs.writeShellApplication {
  name = "hyprlock";
  runtimeInputs = [ pkgs.hyprlock ];
  text = ''
    exec hyprlock --config "${config}" "$@"
  '';
}
