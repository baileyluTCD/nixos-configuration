{
  pkgs,
  flake,
  inputs,
  ...
}:
let
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;

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
  imports = [
    ./ghostty-service.nix
  ];

  programs.niri = {
    package = niriPkg;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    sysmenu
    config-background-daemon
  ];

  security.pam.services.hyprlock = { };

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
        niri = 
      let
        niriLaunch = pkgs.writeShellApplication {
          name = "niri-session";
          text = "${niriPkg}/bin/niri --session";
        };
      in
      {
        prettyName = "Niri";
        comment = "Niri compositor managed by UWSM";
        binPath = "${niriLaunch}/bin/niri-session";
      };
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.uwsm}/bin/uwsm start niri-uwsm.desktop";
        user = "luke";
      };
    };
  };
}
