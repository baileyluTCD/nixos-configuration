{config, ...}: {
  programs.hyprlock = {
    enable = true;

    settings = with config.colorScheme.palette; {
      background = {
        path = "/etc/nixos/home/windowManager/hyprland/hyprpanel/wallpaper.png";

        blur_passes = 2;
        blur_size = 4;

        brightness = 0.8;
        contrast = 0.8;
      };

      input-field = [
        {
          size = "250, 55";
          position = "0, -125";
          halign = "center";
          valign = "center";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(${base05})";
          inner_color = "rgb(${base02})";
          outer_color = "rgb(${base08})";
          rounding = 0.5;
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];

      label = [
        {
          text = "cmd[update:1000] echo \"$TIME\"";
          color = "rgb(${base07})";
          font_size = 150;
          font_family = "FiraCode Nerd Font Mono";
          position = "0, 165";
          halign = "center";
          valign = "center";
          shadow_passes = 5;
          shadow_size = 10;
        }
        {
          text = "cmd[update:0] echo \"$USER\"";
          color = "rgb(${base06})";
          font_size = 30;
          font_family = "FiraCode Nerd Font Mono";
          position = "0, 70";
          halign = "center";
          valign = "center";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];
    };
  };
}
