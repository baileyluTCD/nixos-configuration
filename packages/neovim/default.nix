{
  pkgs,
  pname,
  flake,
  ...
}:
let
  # Nvim Plugins to make avalible
  plugins = pkgs.callPackage ./plugins.nix { vimPlugins = pkgs.vimPlugins; };

  # Produce a valid vim packpath from the plugins list
  packpath = pkgs.runCommandLocal "packpath" { } ''
    mkdir -p $out/pack/${pname}/{start,opt}

    ${pkgs.lib.concatMapStringsSep "\n" (
      plugin: "ln -vsfT ${plugin} $out/pack/${pname}/start/${pkgs.lib.getName plugin}"
    ) plugins}
  '';
in
pkgs.writeShellApplication {
  name = "nvim";

  runtimeInputs = with pkgs; [
    neovim-unwrapped

    # Tools used by config
    ripgrep
    fd
    nodejs_22
    zoxide
    direnv
    tree-sitter
  ];

  runtimeEnv.NVIM_THEME_SLUG = flake.lib.colorScheme.slug;

  text = ''
    exec nvim "$@" \
      --cmd 'set packpath^=${packpath} | set rtp^=${packpath}' \
      --cmd 'set rtp^=${./src}' \
      -u '${./src/init.lua}'
  '';
}
