return {
  'direnv-nvim',
  event = 'DeferredUIEnter',
  after = function()
    require('direnv-nvim').setup {
      type = 'dir',
      async = true,
      on_direnv_finished = function()
        vim.cmd 'AutoLsp refresh'
      end,
    }
  end,
}
