{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$browser" = "firefox";
    "$launcher" = "wofi --show run";
    bind = [
      "$mod, B, exec, $browser"
      "$mod, T, exec, $terminal"
      "$mod, L, exec, $launcher"
      "$mod, K, killactive"
      "$mod, Q, exit"
      "ALT, H, movefocus, l"
      "ALT, J, movefocus, d"
      "ALT, K, movefocus, u"
      "ALT, L, movefocus, r"
      "$mod, 0, workspace, 10"
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
    ];
    exec-once = [ 
       "waybar"
    ];
    monitor = ",preferred,auto,1.2";
    input.kb_layout = "gb";
  };
}
