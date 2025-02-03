return {
  'lazy-lsp.nvim',
  event = 'DeferredUIEnter',
  after = function()
      require('lazy-lsp').setup {
        configs = {
          ['nil_ls'] = {
            settings = {
              ['nil'] = {
                formatting = { command = { 'alejandra' } },
              },
            },
          },
          ['rust_analyzer'] = {
            settings = {
              ['rust-analyzer'] = {
                checkOnSave = {
                  command = 'clippy',
                },
              },
            },
          },
        }
    }
  end,
}
