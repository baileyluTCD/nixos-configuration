-- Neovim syntax highlighting
-- TODO: fix parser dir failing to install
return {
  'nvim-treesitter',
  event = 'DeferredUIEnter',
  after = function()
    local treesitter_parser_dir = '~/.treesitter/'

    require('nvim-treesitter.configs').setup {
      ensure_installed = {},
      ignore_install = {},
      sync_install = false,
      auto_install = true,

      -- Store parsers at this path
      parser_install_dir = treesitter_parser_dir,

      modules = {},

      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    }

    -- Look for parsers in this path
    vim.opt.rtp:append(treesitter_parser_dir)
  end,
}
