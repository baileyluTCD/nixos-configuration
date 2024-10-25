{preferences, ...}: {
  imports =
    if preferences.windowManager == "hyprland"
    then [
      ./hyprland.nix
    ]
    else [];
}
