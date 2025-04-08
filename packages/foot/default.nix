{
  pkgs,
  flake,
  ...
}:
pkgs.writeShellApplication {
  name = "foot";
  runtimeInputs = with pkgs; [
    foot
    nerd-fonts.fira-mono
    flake.packages.${system}.shells
  ];
  text = ''
    exec foot "$@" \
      -c ${./foot.ini}
  '';
}
