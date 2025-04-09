{
  pkgs,
  inputs,
  ...
}: let
  mkRofiWaylandPlugin = plugin: (plugin.override {rofi-unwrapped = pkgs.rofi-wayland-unwrapped;});

  rofi = pkgs.rofi-wayland.override {
    plugins = with pkgs; [
      (mkRofiWaylandPlugin rofi-calc)
      rofi-emoji-wayland
    ];
  };

  rofi-wifi-menu = pkgs.writeShellApplication {
    name = "rofi-wifi-menu";
    runtimeInputs = with pkgs; [iw networkmanager rofi-wayland];
    text = ''
      exec ${inputs.rofi-wifi-menu}/rofi-wifi-menu.sh "$@"
    '';
  };

  rofi-wrapped = pkgs.writeShellApplication {
    name = "rofi";
    runtimeInputs = [
      rofi
      pkgs.wl-clipboard
      pkgs.rofi-obsidian
      pkgs.rofi-power-menu
    ];
    text = ''
      exec rofi "$@" \
        -dpi 130 \
        -config "${./config.rasi}"
    '';
  };
in
  pkgs.symlinkJoin {
    name = "rofi";

    paths = [
      rofi-wrapped
      pkgs.rofi-pass-wayland
      pkgs.rofi-bluetooth
      rofi-wifi-menu
    ];

    meta.mainProgram = "rofi";
  }
