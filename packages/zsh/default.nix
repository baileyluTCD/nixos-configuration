{
  pkgs,
  name,
  version,
  starship-configured,
  macchina-configured,
  ...
}: let
  plugins = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-autocomplete
  ];

  runtime-deps = with pkgs; [
    zoxide
    macchina-configured
    starship-configured
  ];

  pluginDirectories = builtins.map (pkg: "${pkg}/share/") plugins;
in
  pkgs.stdenv.mkDerivation {
    name = name;
    version = version;

    src = ./src;

    # Inputs for wrapping program
    nativeBuildInputs = with pkgs; [
      makeWrapper
    ];

    buildPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/plugins

      for dir in ${builtins.concatStringsSep " " pluginDirectories}; do
        for file in "$dir"/*; do
          ln -s "$file" "$out/plugins/"
        done
      done

      makeWrapper "${pkgs.zsh}/bin/zsh" $out/bin/${name} \
        --set ZSH "${pkgs.oh-my-zsh}/share/oh-my-zsh/" \
        --set ZDOTDIR $src \
        --set ZSH_CUSTOM $out \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}
    '';

    passthru.shellPath = "/bin/zsh";
  }
