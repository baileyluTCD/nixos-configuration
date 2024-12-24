function GruvboxTheme()
  local colors = {
    black = '#282828',
    white = '#ebdbb2',
    red = '#fb4934',
    green = '#b8bb26',
    blue = '#83a598',
    yellow = '#fe8019',
    gray = '#a89984',
    darkgray = '#3c3836',
    lightgray = '#504945',
    inactivegray = '#7c6f64',
  }

  return {
    normal = {
      a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
      b = { bg = colors.lightgray, fg = colors.white },
      c = { bg = colors.darkgray, fg = colors.gray },
    },
    insert = {
      a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
      b = { bg = colors.lightgray, fg = colors.white },
      c = { bg = colors.darkgray, fg = colors.gray },
    },
    visual = {
      a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
      b = { bg = colors.lightgray, fg = colors.white },
      c = { bg = colors.darkgray, fg = colors.gray },
    },
    replace = {
      a = { bg = colors.red, fg = colors.black, gui = 'bold' },
      b = { bg = colors.lightgray, fg = colors.white },
      c = { bg = colors.darkgray, fg = colors.gray },
    },
    command = {
      a = { bg = colors.green, fg = colors.black, gui = 'bold' },
      b = { bg = colors.lightgray, fg = colors.white },
      c = { bg = colors.darkgray, fg = colors.gray },
    },
    inactive = {
      a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
      b = { bg = colors.darkgray, fg = colors.gray },
      c = { bg = colors.darkgray, fg = colors.gray },
    },
  }
end

return {
  'lualine.nvim',
  after = function()
    require('lualine').setup {
      options = {
        theme = GruvboxTheme(),
        icons_enabled = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
        always_divide_middle = false,
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { right = '' } },
        },
        lualine_b = {
          'branch',
          'diff',
          { 'diagnostics', sources = { 'nvim_lsp' } },
        },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = {
          { 'location', separator = { left = '' } },
        },
      },
    }
  end,
}
