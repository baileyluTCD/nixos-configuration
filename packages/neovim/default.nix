{
  pkgs,
  name,
  version,
  ...
}: let
  lib = pkgs.lib;

  # Packages needed for running various functions (LSPs, etc)
  packages = with pkgs; [
    # Tools used by config
    ripgrep
    fd
    nodejs_22
    zoxide
    direnv
    tree-sitter

    # Extra formatters
    alejandra
  ];

  # Nvim Plugins to make avalible
  plugins = with pkgs.vimPlugins; [
    # Lazy load nvim plugins
    lz-n

    # Colorscheme
    gruvbox-nvim
    transparent-nvim

    # Fuzzy finder ui
    telescope-nvim
    telescope-zoxide
    telescope-fzf-native-nvim
    telescope-ui-select-nvim
    nvim-web-devicons

    # Status line
    lualine-nvim

    # File explorer
    oil-nvim

    # Quick file swapping
    harpoon2

    # Git modification signs
    gitsigns-nvim

    # Provides keybind hints
    which-key-nvim

    # Convenience functions
    mini-nvim
    plenary-nvim

    # Language servers
    nvim-lspconfig
    fidget-nvim

    # Syntax Highlighting
    nvim-treesitter
    todo-comments-nvim

    # Autocomplete
    nvim-cmp
    luasnip
    cmp_luasnip
    cmp-nvim-lsp
    cmp-path

    # Code formatting
    conform-nvim

    # Smart indentation
    vim-sleuth

    # Start screen
    startup-nvim

    # Portable environment setup
    lazy-lsp-nvim
    direnv-vim
  ];

  # Produce a valid vim packpath from the plugins list
  packpath = pkgs.runCommandLocal "packpath" {} ''
    mkdir -p $out/pack/${name}/{start,opt}

    ${
      lib.concatMapStringsSep
      "\n"
      (plugin: "ln -vsfT ${plugin} $out/pack/${name}/start/${lib.getName plugin}")
      plugins
    }
  '';
in
  pkgs.stdenv.mkDerivation {
    name = name;
    version = version;

    src = ./src;

    # Inputs for wrapping program
    nativeBuildInputs = with pkgs; [
      makeWrapper
    ];

    # This wrapper adds our plugins to the nevim package path
    # And points the configuration to the init.lua in ./src bundled
    # With the derivation
    buildPhase = ''
      export NVIM_DIR=$out/bin
      mkdir -p $out/bin

      makeWrapper "${pkgs.neovim-unwrapped}/bin/nvim" $out/bin/${name} \
        --add-flags "--cmd 'set packpath^=${packpath} | set rtp^=${packpath}'" \
        --add-flags "--cmd 'set rtp^=$out/bin'" \
        --add-flags "-u '$out/bin/init.lua'" \
        --prefix PATH : ${lib.makeBinPath packages}
    '';

    installPhase = ''
      cp -r $src/* $out/bin
    '';
  }
