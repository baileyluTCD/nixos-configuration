{
  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;  # For GDM/Wayland sessions
}
