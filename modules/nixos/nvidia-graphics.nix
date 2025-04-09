{pkgs, ...}: {
  # Enable graphics within this config
  hardware.graphics.enable = true;

  # Install nvidia x11 video drivers
  services.xserver.videoDrivers = ["nvidia"];

  # Enable nvidia graphics cards
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  environment.systemPackages = with pkgs; [
    # Enable PCI tools cli for interacting with stuff like graphics cards
    pciutils
  ];

  # Allow using nvidia drivers
  nixpkgs.config.allowUnfree = true;
}
