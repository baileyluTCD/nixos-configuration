{pkgs, ...}:
pkgs.writeShellApplication {
  name = "zsh";

  runtimeInputs = with pkgs; [
    hyprpaper
  ];

  text = ''
    cd ${./src}

    exec hyprpaper --config ./hyprpaper.conf
  '';
}
