{
  pkgs,
  flake,
  ...
}: let
  runtime-deps = with pkgs; [
    grim
    slurp
    wireplumber
    brightnessctl
    wl-clipboard
    flake.hyprlock
    flake.hyprpaper
    flake.neovide
    flake.rofi
    flake.rofi
    flake.waybar
    flake.wezterm
    flake.zen
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
