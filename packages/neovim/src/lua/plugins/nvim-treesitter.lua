-- Neovim syntax highlighting
-- TODO: fix parser dir failing to install
return {
  'nvim-treesitter',
  event = 'DeferredUIEnter',
  after = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {},
      ignore_install = {},
      sync_install = false,
      auto_install = false,

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
  end,
}
