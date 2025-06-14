{
  # Define your hostname.
  networking.hostName = "nixos";

  # Load nmtui (depends on wpa_supplicant)
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };

  # Enable network tracing and pinging
  # https://wiki.nixos.org/wiki/Mtr
  programs.mtr.enable = true;

  # Enable gnu privacy guard
  # https://gnupg.org/
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Use nftables (newer) over iptables
  networking.nftables.enable = true;
}
