{pkgs, ...}:
pkgs.writeShellApplication {
  name = "zsh";

  runtimeInputs = with pkgs; [
    hyprpaper
  ];

  runtimeEnv.HYPRPAPER_BACKGROUND = ./src/background.jpg;

  text = ''
    exec hyprpaper --config ${./src/hyprpaper.conf}
  '';
}
