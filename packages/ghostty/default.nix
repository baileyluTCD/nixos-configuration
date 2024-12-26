{
  ghostty,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ghostty.default
    fira-code-nerdfont
    freshfetch
  ];

  home.file = {
    "ghostty-config" = {
      source = ./src;
      target = ".config/ghostty";
      recursive = true;
    };
  };
}
