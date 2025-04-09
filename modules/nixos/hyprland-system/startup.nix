{
  pkgs,
  config,
  flake,
  system,
  ...
}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable usage of hyprlock lock screen through pam
  # https://en.wikipedia.org/wiki/Linux_PAM
  security.pam.services.hyprlock = {};

  # Use zsh as the default shell system wide over bash
  users.defaultUserShell = flake.packages.${system}.zsh;

  programs.hyprland = {
    package = flake.packages.${system}.hyprland;
    enable = true;
    withUWSM = true;
  };

  programs.uwsm.enable = true;

  # Boot into hyprland on startup
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        user = config.users.primary;
      };
    };
  };
}
