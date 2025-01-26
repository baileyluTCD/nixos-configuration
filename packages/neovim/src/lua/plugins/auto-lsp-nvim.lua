return {
  'auto-lsp-nvim',
  event = 'DeferredUIEnter',
  after = function()
    require('auto-lsp').setup {
      ['*'] = function()
        return {
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
      end,

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
  end,
}
