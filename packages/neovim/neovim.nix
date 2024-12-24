{pkgs, ...}: let
  # Fetch plugins not on nixpkgs from git
  telescope-repo-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "telescope-repo-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "cljoly";
      repo = "telescope-repo.nvim";
      rev = "89b0c19b9f962d017bf466625d5056214efb1be9";
      sha256 = "SIiOOqt7F5pD8oSVNtOrpC+wwnSFfR2vU297hIFm6ho=";
    };
  };
in {
  # Load packages neovim depends on such as LSPs, etc
  home.packages = with pkgs; [
    # Animated graphical frontend for nvim
    neovide

    # Tools used by config
    ripgrep
    fd
    nodejs_23

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

      # Colorscheme
      gruvbox-nvim

      # Fuzzy finder ui
      telescope-nvim
      telescope-repo-nvim
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

  # Symlink the rest of the neovim config so that it can be accessed from the init.lua file
  home.file = {
    "nvim-config" = {
      source = ./src;
      target = ".config/nvim";
      recursive = true;
    };
  };
}
