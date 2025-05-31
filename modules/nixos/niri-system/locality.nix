{
  # Set your time zone
  time.timeZone = "Europe/Dublin";

  # Use the hyper key instead of caps lock
  services.xserver.xkbOptions = "caps:hyper";

  # Set language locale
  i18n.defaultLocale = "en_IE.UTF-8";

  # Set keyboard type used
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };
}
