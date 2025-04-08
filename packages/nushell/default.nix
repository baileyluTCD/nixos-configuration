{
  pkgs,
  flake,
  ...
}:
pkgs.writeShellApplication {
  name = "nu";

  runtimeInputs = with pkgs; [
    nushell
    flake.packages.${system}.cli-utils
  ];

  text = ''
    cd ${./src}

    exec nu \
      --config "./config.nu" \
      "$@"
  '';

  passthru.shellPath = "/bin/nu";
}
