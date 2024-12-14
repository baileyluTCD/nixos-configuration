{
  # Define your hostname.
  networking.hostName = "nixos";

  # Load nmtui (depends on wpa_supplicant)
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443 22 8080];
    allowedUDPPortRanges = [
      {
        from = 22;
        to = 22;
      }
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8080;
      }
    ];
  };
}
