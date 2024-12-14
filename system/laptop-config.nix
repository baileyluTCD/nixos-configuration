{
  # Enable fan control for laptop fans
  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  # Provide power management support for systems which have a battery such as a laptop
  services.upower.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
}
