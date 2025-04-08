{
  pkgs,
  flake,
  ...
}:
pkgs.writeShellApplication {
  name = "waybar";

  runtimeInputs = with pkgs; [
    flake.packages.${system}.hyprlock
    nerd-fonts.fira-code
    power-profiles-daemon
    waybar
  ];

  text = ''
    waybar \
      --config ${./src/config.jsonc} \
      --style ${./src/style.css}
  '';
}
