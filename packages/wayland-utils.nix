{pkgs, flake, ...}:
pkgs.symlinkJoin {
  name = "wayland-utils";

  paths = with pkgs; [
    grim
    slurp
    wireplumber
    wl-clipboard
  ];
}
