{ pkgs, ... }:
{
  users.users.luke = {
    isNormalUser = true;
    createHome = true;
    description = "Luke Bailey";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  nix.settings.trusted-users = [
    "luke"
    "root"
  ];
}
