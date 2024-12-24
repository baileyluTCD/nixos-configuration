-- Gruvbox colorscheme
return {
  'gruvbox.nvim',
  event = 'UIEnter',
  after = function()
    require('gruvbox').setup()

    vim.cmd 'colorscheme gruvbox'
  end,
}
