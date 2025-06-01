{
  pkgs,
  flake,
  ...
}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use zsh as the default shell system wide over bash
  users.defaultUserShell = flake.packages.${pkgs.system}.zsh;
}
