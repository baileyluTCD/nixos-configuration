{
  # Define your hostname.
  networking.hostName = "nixos";

  # Load nmtui (depends on wpa_supplicant)
  networking.networkmanager.enable = true;

  # Enable network tracing and pinging
  # https://wiki.nixos.org/wiki/Mtr
  programs.mtr.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
  };

  # Enable gnu privacy guard
  # https://gnupg.org/
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
