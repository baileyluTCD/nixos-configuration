{preferences, ...}: {
  imports = [
    ./hyprland/rofi.nix
    ./hyprland/hyperpanel.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$mod_shift" = "SUPER_SHIFT";
      "$terminal" = preferences.terminal.program;
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
        "hyprpanel"
      ];
      monitor = ",preferred,auto,1.2";
      input.kb_layout = "gb";
      windowrulev2 = [
        ("opacity ${toString preferences.terminal.opacity} ${toString preferences.terminal.opacity},"
          + "class:^(${preferences.terminal.program})$")
      ];
      decoration = {
        rounding = 4;
      };
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
