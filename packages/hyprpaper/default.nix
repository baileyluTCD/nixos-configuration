{pkgs, ...}:
pkgs.writeShellApplication {
  name = "hyprpaper";

  runtimeInputs = with pkgs; [
    hyprpaper
  ];

  text = ''
    cd ${./src}

    exec hyprpaper --config ./hyprpaper.conf
  '';
}
