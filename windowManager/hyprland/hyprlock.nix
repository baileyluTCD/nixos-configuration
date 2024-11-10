{
  programs.hyprlock = {
    enable = true;

    settings = {
      background = {
        path = "/home/luke/.config/home-manager/windowManager/hyprland/hyprpanel/wallpaper.png";

        blur_passes = 2;
        blur_size = 4;

        brightness = 0.8;
        contrast = 0.8;
      };

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(CFE6F4)";
          inner_color = "rgb(657DC2)";
          outer_color = "rgb(0D0E15)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];

      label = {
        monitor = "";
        text = "cmd[update:1000] echo \"$TIME\"";
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 55;
        font_family = "FiraCode Nerd Font Mono";
        position = "-100, 70";
        halign = "right";
        valign = "bottom";
        shadow_passes = 5;
        shadow_size = 10;
      };
    };
  };
}
