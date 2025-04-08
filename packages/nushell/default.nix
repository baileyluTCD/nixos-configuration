{
  pkgs,
  flake,
  ...
}:
pkgs.writeShellApplication {
  name = "nu";

  runtimeInputs = with pkgs; [
    nushell
    zoxide
    bat
    carapace
    flake.packages.${system}.starship
    flake.packages.${system}.macchina
  ];

  text = ''
    cd ${./src}

    exec nu \
      --config "./config.nu" \
      "$@"
  '';

  passthru.shellPath = "/bin/nu";
}
