{...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "~/.config/home-manager/windowManager/hyprland/hyprpaper/wallpaper.png";
      wallpaper = ",~/.config/home-manager/windowManager/hyprland/hyprpaper/wallpaper.png";
    };
  };
}
