{ ... }:
{
  # Provide power management support for systems which have a battery such as a laptop
  services.upower.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Autotune power usage
  services.tlp.enable = true;
}
