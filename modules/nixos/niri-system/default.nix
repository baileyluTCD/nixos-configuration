{
  pkgs,
  flake,
  inputs,
  ...
}:
let
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;

  config-background-daemon = pkgs.writeShellApplication {
    name = "config-background-daemon";
    runtimeInputs = with pkgs; [
      swaybg
      swww
    ];
    text = ''
      swaybg -i ${./desktopBackgroundBlurred.png} &

      swww-daemon &
      swww img ${./desktopBackground.png}
    '';
  };
in
{
  programs.niri = {
    package = flake.packages.${pkgs.system}.niri;
    enable = true;
  };

  programs.regreet = {
    theme = {
      name = "${flake.lib.colorScheme.slug}";
      package = gtkThemeFromScheme {scheme = flake.lib.colorScheme;};
    };
    font = {
      name = "Adwaita";
      package = pkgs.adwaita-fonts;
    };
    extraCss = ''
      box, container {
        border-radius: 10px;
      }
    '';
    settings.background.path = ./desktopBackground.png;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    sysmenu
    config-background-daemon
  ];
}
