{pkgs, ...}: {
  # Load packages neovim depends on such as LSPs, etc
  home.packages = with pkgs; [
    # Animated graphical frontend for nvim
    neovide

    # Tools used by config
    ripgrep
    fd
    nodejs_22
    zoxide

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
  ];

  # Configure neovim from a file
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
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
  };

  # Symlink the neovim configuration to the home directory so it is loaded when neovim is started
  home.file = {
    "nvim-config" = {
      source = ./src;
      target = ".config/nvim";
      recursive = true;
    };
  };
}
