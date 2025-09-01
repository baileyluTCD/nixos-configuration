-- Base16 Colorscheme
return {
  'base16-colorscheme',
  event = 'UIEnter',
  after = function()
    local theme_slug = vim.env.NVIM_THEME_SLUG or os.getenv("NVIM_THEME_SLUG")

    local set_theme = string.format('colorscheme base16-%s', theme_slug)

    vim.cmd(set_theme)
    vim.opt.termguicolors = true
  end,
}
