{...}: {
  # Mount second ssd to home
  fileSystems."/home" = {
    device = "/dev/sda";
    fsType = "ext4";
  };

  # Create a swap file the same size as system ram so hibernation can work
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
}
