{ vimPlugins, ... }:
with vimPlugins;
[
  # Lazy load nvim plugins
  lz-n

  # Colorscheme
  base16-nvim
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

  # Git
  gitsigns-nvim
  lazygit-nvim

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
]
