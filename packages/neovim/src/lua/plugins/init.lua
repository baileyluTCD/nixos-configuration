-- Initialize plugins with no .setup() step
return {
  -- Detect tabstop and shiftwidth automatically
  { 'vim-sleuth', event = 'DeferredUIEnter' },
}
