{pkgs, ...}: {
  users.users.luke = {
    isNormalUser = true;
    createHome = true;
    description = "Luke Bailey";
    extraGroups = ["wheel" "networkmanager"];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.niri}/bin/niri";
        user = "luke";
      };
    };
  };

  nix.settings.trusted-users = [ "luke" "root" ];
}
