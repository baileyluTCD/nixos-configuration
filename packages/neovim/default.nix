{
  pkgs,
  name,
  version,
  ...
}: let
  lib = pkgs.lib;

  # Packages needed for running various functions (LSPs, etc)
  packages = with pkgs; [
    # Animated graphical frontend for nvim
    neovide
    fira-code-nerdfont

    # Tools used by config
    ripgrep
    fd
    nodejs_22
    zoxide
    direnv

    # Formatters
    stylua
    alejandra

    # Language servers and their dependencies
    rustup
    mold

    elixir
    elixir-ls

    clang-tools
    lemminx
    lua-language-server
    nil
    jdt-language-server
    typescript-language-server
    nushell

    python312Full
    python312Packages.jedi-language-server
  ];

  # Plugins to make avalible
  plugins = with pkgs.vimPlugins; [
    # Lazy load nvim plugins
    lz-n

    # Colorscheme
    gruvbox-nvim

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

    # Environment
    direnv-vim

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

    # Runtime inputs
    buildInputs = packages;

    buildPhase = ''
      export NVIM_DIR=$out/bin
      mkdir -p $out/bin

      makeWrapper "${pkgs.neovim-unwrapped}/bin/nvim" $out/bin/${name} \
        --add-flags "--cmd 'set packpath^=${packpath} | set rtp^=${packpath}'" \
        --add-flags "--cmd 'set rtp^=$out/bin'" \
        --add-flags "-u '$out/bin/init.lua'"
    '';

    installPhase = ''
      cp -r $src/* $out/bin
    '';
  }
