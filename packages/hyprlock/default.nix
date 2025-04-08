{pkgs, ...}:
pkgs.writeShellApplication {
  name = "hyprlock";

  runtimeInputs = with pkgs; [
    hyprlock
  ];

  runtimeEnv.HYPRLOCK_BACKGROUND = ../hyprpaper/src/background.jpg;

  text = ''
    exec hyprlock --config ${./hyprlock.conf}
  '';
}
