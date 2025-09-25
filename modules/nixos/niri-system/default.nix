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

  niriPkg = flake.packages.${pkgs.system}.niri;
in
{
  programs.niri = {
    package = niriPkg;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    sysmenu
    config-background-daemon
  ];

  security.pam.services.hyprlock = {};

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${niriPkg}/bin/niri --session";
        user = "luke";
      };
    };
  };
}
