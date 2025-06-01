{
  pkgs,
  flake,
  ...
}: 
 let config-background-daemon = pkgs.writeShellApplication {
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
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordzy-dark";
      package = pkgs.nordzy-icon-theme;
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
    };
    font = {
      name = "Inter";
      package = pkgs.inter-nerdfont;
    };
    settings.background.path = ./desktopBackground.png;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    sysmenu
    config-background-daemon
  ];
}
