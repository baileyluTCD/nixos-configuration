{pkgs, ...}: {
  users.users.luke = {
    isNormalUser = true;
    createHome = true;
    description = "Luke Bailey";
    extraGroups = ["wheel" "networkmanager"];
  };

  # Boot into hyprland on startup
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        user = "luke";
      };
    };
  };

  nix.settings.trusted-users = [ "luke" "root" ];
}
