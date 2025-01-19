{
  pkgs,
  config,
  zsh-configured,
  ...
}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Manage enviroenvironment variables
  environment.variables = {
    # Enable wayland support for electron apps
    NIXOS_OZONE_WL = "1";
  };

  # Boot into hyprland on startup
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = config.users.primary;
      };
      default_session = initial_session;
    };
  };

  # Enable usage of hyprlock lock screen through pam
  # https://en.wikipedia.org/wiki/Linux_PAM
  security.pam.services.hyprlock = {};

  # Use zsh as the default shell system wide over bash
  programs.zsh.enable = true;
  users.defaultUserShell = zsh-configured;

  # Enable unconfigured hyprland as minimum for each user
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    # Add the lockscreen package
    hyprlock
  ];
}
