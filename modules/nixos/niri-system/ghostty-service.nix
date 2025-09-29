{ flake, pkgs, ... }:
let
  ghosttyPkg = flake.packages.${pkgs.system}.ghostty;
in
{
  systemd.user.services."app-com.mitchellh.ghostty" = {
    enable = true;
    after = [
      "graphical-session.target"
      "dbus.socket"
    ];
    requires = [
      "graphical-session.target"
      "dbus.socket"
    ];
    description = "Ghostty";
    environment = pkgs.lib.mkForce {};
    serviceConfig = {
      Type = "notify-reload";
      ReloadSignal = "SIGUSR2";
      BusName = "com.mitchellh.ghostty";
      ExecStart = ''
        ${ghosttyPkg}/bin/ghostty --gtk-single-instance=true --initial-window=false
      '';
    };
  };
}
