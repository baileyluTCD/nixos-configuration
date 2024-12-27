{
  wezterm,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    wezterm.default
    fira-code-nerdfont
    freshfetch
  ];

  home.file = {
    "wezterm-config" = {
      source = ./src;
      target = ".config/wezterm";
      recursive = true;
    };
  };
}
