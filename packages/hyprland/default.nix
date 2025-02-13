{
  pkgs,
  hyprlock-configured,
  hyprpaper-configured,
  neovide-configured,
  rofi-configured,
  waybar-configured,
  wezterm-configured,
  zen-configured,
  ...
}: let
  runtime-deps = with pkgs; [
    grim
    slurp
    wireplumber
    brightnessctl
    wl-clipboard
    hyprlock-configured
    hyprpaper-configured
    neovide-configured
    rofi-configured
    rofi-pass-wayland
    waybar-configured
    wezterm-configured
    zen-configured
  ];
in (self: super: {
  hyprland = super.hyprland.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        cp -R ${./src} $out/share/custom

        cp $out/bin/Hyprland $out/bin/HyprlandVanilla

        makeWrapper $out/bin/HyprlandVanilla $out/bin/Hyprland \
          --add-flags "--config $out/share/custom/hyprland.conf" \
          --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
      '';
  });
})
