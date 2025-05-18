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
    config_dir=${./src}

    exec nu \
      --config "$config_dir/config.nu" \
      "$@"
  '';

  passthru.shellPath = "/bin/nu";
}
