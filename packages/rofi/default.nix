{
  pkgs,
  name,
  version,
  ...
}: let
  rofi-wifi-menu = pkgs.stdenv.mkDerivation {
    pname = "rofi-network-manager";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "zbaylin";
      repo = "rofi-wifi-menu";
      rev = "bd5f34f8c079a92bebf1885f2d68bc3a160e3742";
      hash = "sha256-gR77JyAPyfL/IassMA9rM3crAp24lNjXOKIx4NHtbzs=";
    };

    buildInputs = with pkgs; [
      rofi-wayland-unwrapped
      networkmanager
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp -R $src/rofi-wifi-menu.sh $out/bin/rofi-wifi-menu
      chmod +x $out/bin/rofi-wifi-menu
    '';
  };

  mkRofiWaylandPlugin = plugin: (plugin.override {rofi-unwrapped = pkgs.rofi-wayland-unwrapped;});

  rofi = pkgs.rofi-wayland.override {
    plugins = with pkgs; [
      (mkRofiWaylandPlugin rofi-calc)
      rofi-emoji-wayland
    ];
  };

  runtime-deps = with pkgs; [
    wl-clipboard
    rofi-obsidian
    rofi-power-menu
  ];

  scripts = with pkgs; [
    rofi-pass-wayland
    rofi-bluetooth
    rofi-wifi-menu
  ];

  exposeRofiScript = script: ''
    cp ${script}/bin/* $out/bin/
  '';
in
  pkgs.stdenv.mkDerivation {
    name = name;
    version = version;

    src = ./config.rasi;

    phases = ["buildPhase"];

    # Inputs for wrapping program
    nativeBuildInputs = with pkgs; [
      makeWrapper
    ];

    buildPhase = ''
      mkdir -p $out/bin

      cp -r $src $out/bin

      makeWrapper "${rofi}/bin/rofi" $out/bin/${name} \
        --add-flags "-dpi 130" \
        --add-flags "-config $src" \
        --prefix PATH : ${pkgs.lib.makeBinPath runtime-deps}

      ${builtins.concatStringsSep "\n" (map exposeRofiScript scripts)}
    '';
  }
