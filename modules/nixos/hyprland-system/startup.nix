{
  pkgs,
  flake,
  ...
}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable usage of hyprlock lock screen through pam
  # https://en.wikipedia.org/wiki/Linux_PAM
  security.pam.services.hyprlock = {};

  # Use zsh as the default shell system wide over bash
  users.defaultUserShell = flake.packages.${pkgs.system}.zsh;

  programs.hyprland = {
    package = flake.packages.${pkgs.system}.hyprland;
    enable = true;
    withUWSM = true;
  };

  programs.uwsm.enable = true;
}
