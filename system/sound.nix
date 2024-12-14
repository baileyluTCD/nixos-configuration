{pkgs, ...}: {
  # Enable sound through the pipewire service:
  # See https://www.pipewire.org/
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enables rtkit, which is needed for audio servers like pipewire or pulse audio
  # See `https://mynixos.com/nixpkgs/option/security.rtkit.enable`
  security.rtkit.enable = true;

  # Enable packages used to support audio and audio cli tools
  environment.systemPackages = with pkgs; [
    pulseaudio
  ];
}
