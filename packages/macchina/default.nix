{ pkgs, flake, ... }: let 
  theme = pkgs.replaceVars ./src/ColorsTheme.toml (with flake.lib.colorScheme.palette; {
    keyColor = base06;
    separatorColor = base0A;
    asciiColor = base07;
  });

  runDir = pkgs.runCommand "macchina-work-dir" {} ''
    mkdir -p $out

    cp "${theme}" $out/ColorsTheme.toml

    cp -r --update=none "${./src}/." $out
  '';
in
pkgs.writeShellApplication {
  name = "macchina";
  runtimeInputs = [ pkgs.macchina ];
  text = ''
    cd "${runDir}"

    exec macchina \
      --config "${runDir}/Macchina.toml" \
      --theme "${runDir}/ColorsTheme" \
      "$@"
  '';
}
