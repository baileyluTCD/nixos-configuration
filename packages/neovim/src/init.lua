-- Load configuration for the editor itself from the ./lua/editor/ directory
require("editor.keymaps")
require("editor.opts")
require("editor.autocommands")

-- Load plugins from the ./lua/plugins/ directory
require("lz.n").load("plugins")

print("Initialized neovim config!")
