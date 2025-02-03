{
  pkgs,
  config,
  zsh-configured,
  hyprland-configured,
  ...
}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable usage of hyprlock lock screen through pam
  # https://en.wikipedia.org/wiki/Linux_PAM
  security.pam.services.hyprlock = {};

  # Use zsh as the default shell system wide over bash
  users.defaultUserShell = zsh-configured;

  # Boot into hyprland on startup
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.uwsm}/bin/uwsm start ${hyprland-configured}/bin/Hyprland";
        user = config.users.primary;
      };
      default_session = initial_session;
    };
  };

  environment.systemPackages = with pkgs; [
    # Add the lockscreen package
    hyprlock

    # Enable custom zsh
    zsh-configured
  ];
}
