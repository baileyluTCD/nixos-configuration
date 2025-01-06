{preferences, ...}: {
  imports = [
    ./hyprland/rofi.nix
    ./hyprland/hyperpanel.nix
    ./hyprland/hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$mod_shift" = "SUPER_SHIFT";
      "$terminal" = "wezterm";
      "$browser" = preferences.browser;
      "$launcher" = "rofi -show drun";
      bind = [
        "$mod, B, exec, $browser"
        "$mod, T, exec, $terminal"
        "$mod, A, exec, $launcher"
        "$mod, D, killactive"
        "$mod, Q, exit"
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod_shift, H, movetoworkspace, -1"
        "$mod_shift, L, movetoworkspace, +1"
        "$mod_shift, 0, movetoworkspace, 10"
        "$mod_shift, 1, movetoworkspace, 1"
        "$mod_shift, 2, movetoworkspace, 2"
        "$mod_shift, 3, movetoworkspace, 3"
        "$mod_shift, 4, movetoworkspace, 4"
        "$mod_shift, 5, movetoworkspace, 5"
        "$mod_shift, 6, movetoworkspace, 6"
        "$mod_shift, 7, movetoworkspace, 7"
        "$mod_shift, 8, movetoworkspace, 8"
        "$mod_shift, 9, movetoworkspace, 9"
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
        "$mod, Tab, workspace, e+1"
        "$mod_shift, Tab, workspace, e-1"
        "$mod, S, exec, grim -g \"$(slurp -d)\" - | wl-copy"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
      ];
      exec-once = [
        "hyprlock || hyprctl dispatch exit"
        "hyprpanel"
      ];
      monitor = ",preferred,auto,1.2";
      input.kb_layout = "gb";
      decoration = {
        rounding = 4;
      };
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
