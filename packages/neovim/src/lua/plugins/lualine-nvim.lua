return {
  'lualine.nvim',
  after = function()
    -- TODO: remove ugly middle section somehow
    require('lualine').setup {
      theme = 'auto',
      options = {
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { 'mode', right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { { '%=', color = 'None' } },
        lualine_x = { { '%=', color = 'None' } },
        lualine_y = { 'filetype' },
        lualine_z = {
          { 'location', left_padding = 2 },
        },
      },
    }
  end,
}
