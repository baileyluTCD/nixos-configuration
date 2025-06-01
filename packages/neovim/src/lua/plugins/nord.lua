-- Nord colorscheme
return {
  'nord.nvim',
  event = 'UIEnter',
  after = function()
    vim.cmd 'colorscheme nord'
  end,
}
