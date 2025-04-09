{
  pkgs,
  flake,
  ...
}: let
  server = pkgs.writeShellApplication {
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
};

  client = pkgs.writeShellApplication {
  name = "footclient";
  runtimeInputs = with pkgs; [
    foot
  ];
  text = ''
    exec footclient "$@"
  '';
  };

in
pkgs.symlinkJoin {
  name = "foot";

  paths = [
    server
    client
  ];
}
