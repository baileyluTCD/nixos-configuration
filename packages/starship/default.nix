{pkgs, ...}:
pkgs.writeShellApplication {
  name = "starship";
  runtimeInputs = [pkgs.starship];
  runtimeEnv.STARSHIP_CONFIG = ./starship.toml;
  text = ''
    exec starship "$@"
  '';
}
