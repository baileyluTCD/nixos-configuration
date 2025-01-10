-- Initialize plugins with no .setup() step
return {
  -- Detect tabstop and shiftwidth automatically
  { 'vim-sleuth', event = 'DeferredUIEnter' },
  -- Load environment with direnv
  { 'direnv.vim', event = 'DeferredUIEnter' },
}
