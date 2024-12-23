{
  config,
  pkgs,
  lib,
  ...
}: {
  # Load packages neovim depends on such as LSPs, etc
  home.packages = with pkgs; [
    # Animated graphical frontend for nvim
    neovide

    # Formatters
    stylua
    alejandra

    # Language servers
    clang-tools
    lemminx
    rust-analyzer
    lua-language-server
    nil
    jdt-language-server
    elixir-ls
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

      # Fuzzy finder ui
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      nvim-web-devicons

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
      nvim-treesitter.withAllGrammars
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

  # Symlink the rest of the neovim config so that it can be accessed from the init.lua file
  home.file = {
    "nvim-config" = {
      source = ./src;
      target = ".config/nvim";
      recursive = true;
    };
  };
}
