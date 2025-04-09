{
  pkgs,
  inputs,
  ...
}:
pkgs.writeShellApplication {
  name = "rofi-wifi-menu";
  runtimeInputs = with pkgs; [iw networkmanager rofi-wayland];
  text = ''
    exec ${inputs.rofi-wifi-menu}/rofi-wifi-menu.sh "$@"
  '';
}
