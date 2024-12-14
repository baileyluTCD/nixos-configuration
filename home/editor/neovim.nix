{ lib, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = with config.colorScheme.palette;
      ''
        vim.opt.termguicolors = true

        -- Base UI colors
        vim.cmd("highlight Normal guifg=#${base05} guibg=#${base00}")
        vim.cmd("highlight Cursor guifg=#${base00} guibg=#${base05}")
        vim.cmd("highlight LineNr guifg=#${base03}")
        vim.cmd("highlight CursorLineNr guifg=#${base0A}")
        vim.cmd("highlight StatusLine guifg=#${base04} guibg=#${base02}")
        vim.cmd("highlight StatusLineNC guifg=#${base03} guibg=#${base01}")
        vim.cmd("highlight VertSplit guifg=#${base02}")
        vim.cmd("highlight Visual guibg=#${base02}")
        vim.cmd("highlight MatchParen guifg=#${base05} guibg=#${base03}")

        -- Syntax elements
        vim.cmd("highlight Comment guifg=#${base03} gui=italic")
        vim.cmd("highlight Constant guifg=#${base09}")
        vim.cmd("highlight String guifg=#${base0B}")
        vim.cmd("highlight Character guifg=#${base0C}")
        vim.cmd("highlight Number guifg=#${base09}")
        vim.cmd("highlight Boolean guifg=#${base09}")
        vim.cmd("highlight Float guifg=#${base09}")
        vim.cmd("highlight Identifier guifg=#${base08}")
        vim.cmd("highlight Function guifg=#${base0D}")
        vim.cmd("highlight Statement guifg=#${base0E}")
        vim.cmd("highlight Conditional guifg=#${base0E}")
        vim.cmd("highlight Repeat guifg=#${base0E}")
        vim.cmd("highlight Label guifg=#${base0A}")
        vim.cmd("highlight Operator guifg=#${base05}")
        vim.cmd("highlight Keyword guifg=#${base0E}")
        vim.cmd("highlight Exception guifg=#${base08}")
        vim.cmd("highlight PreProc guifg=#${base0A}")
        vim.cmd("highlight Type guifg=#${base0A}")
        vim.cmd("highlight Special guifg=#${base0C}")
        vim.cmd("highlight SpecialChar guifg=#${base0C}")
        vim.cmd("highlight Tag guifg=#${base0A}")
        vim.cmd("highlight Delimiter guifg=#${base05}")

        -- Diagnostics
        vim.cmd("highlight DiagnosticError guifg=#${base08}")
        vim.cmd("highlight DiagnosticWarn guifg=#${base09}")
        vim.cmd("highlight DiagnosticInfo guifg=#${base0D}")
        vim.cmd("highlight DiagnosticHint guifg=#${base0C}")

        -- Diff mode
        vim.cmd("highlight DiffAdd guibg=#${base0B}")
        vim.cmd("highlight DiffChange guibg=#${base0D}")
        vim.cmd("highlight DiffDelete guibg=#${base08}")
        vim.cmd("highlight DiffText guibg=#${base0E}")

        -- Popups and floating windows
        vim.cmd("highlight Pmenu guibg=#${base01} guifg=#${base05}")
        vim.cmd("highlight PmenuSel guibg=#${base02} guifg=#${base05}")
        vim.cmd("highlight PmenuSbar guibg=#${base02}")
        vim.cmd("highlight PmenuThumb guibg=#${base04}")

        -- TreeSitter specific groups
        vim.cmd("highlight @comment guifg=#${base03} gui=italic")
        vim.cmd("highlight @keyword guifg=#${base0E}")
        vim.cmd("highlight @string guifg=#${base0B}")
        vim.cmd("highlight @variable guifg=#${base05}")
        vim.cmd("highlight @function guifg=#${base0D}")
        vim.cmd("highlight @type guifg=#${base0A}")
        vim.cmd("highlight @operator guifg=#${base05}")

        -- Additional UI elements
        vim.cmd("highlight Search guibg=#${base03} guifg=#${base05}")
        vim.cmd("highlight IncSearch guibg=#${base0A} guifg=#${base00}")
        vim.cmd("highlight TabLine guibg=#${base01} guifg=#${base04}")
        vim.cmd("highlight TabLineSel guibg=#${base02} guifg=#${base05}")
        vim.cmd("highlight TabLineFill guibg=#${base00}")
        vim.cmd("highlight CursorLine guibg=#${base01}")
        vim.cmd("highlight CursorColumn guibg=#${base01}")

      '' + lib.fileContents ./neovim/init.lua
      ;
  };

  home.sessionVariables.EDITOR = "nvim";
}
