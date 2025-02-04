The [neovim](https://neovim.io/) [[Package|package]] describes an entire neovim configuration in a declarative manner.

View the code for this [[Package|package]] [here](https://github.com/baileyluTCD/nixos-configuration/tree/master/packages/neovim).

![[Neovim Image.png]]

---
### Package Management with Nix
While neovim has **many package managers** to choose from, such as [packer](https://github.com/wbthomason/packer.nvim) or [lazy](https://github.com/folke/lazy.nvim), we already have access to [the world's largest package manager](https://discourse.nixos.org/t/nixpkgs-has-been-the-largest-repository-for-months/10667), [nixpkgs](https://search.nixos.org/packages). Hence, we want to try find a way to declare all of our dependencies for neovim **using nix** because it meshes far better with our existing [[Architecture|system configuration]] and eliminates duplicate dependencies.

> [!note] Options
> To achieve this, we have a number of options to choose from:
> - The popular [nixvim](https://nix-community.github.io/nixvim/), which allows for configuration of neovim in pure nix without relying on [lua](https://www.lua.org/) or [vimscript](https://learnvimscriptthehardway.stevelosh.com/).
> - Using the [built in neovim](https://nixos.wiki/wiki/Neovim) `program` and manually configuring neovim

We will opt to use the [built in neovim](https://nixos.wiki/wiki/Neovim) `program` and attach our own [lua](https://www.lua.org/) configuration ourselves. 

> [!abstract] Selecting Default Neovim
> While it may seem tempting to use nixvim and attempt to configure everything in nix, I believe this is a bad idea for a few reasons:
> - It requires a **double configuration** of sorts where you often find yourself reading a package's **native lua documentation** and having to find a way to **translate it** back to neovim
> - Many packages either **do not have exposed nixvim configuration** meaning you will have to write lua in **inlined strings** in your nix configuration, foregoing the benefits of **LSPs** and **formatters**.
> - Worse still, many slightly **lesser known packages** do not exist on the nixpkgs registry full stop, making them much **harder to use with nixvim**, while the original vim and neovim packages have a convenient method for importing packages via git.

---
### Configuring neovim with lua
In order to configure neovim with lua we can simply create a regular `init.lua` file and [symlink](https://www.freecodecamp.org/news/symlink-tutorial-in-linux-how-to-create-and-remove-a-symbolic-link/) it into our home directory with nix, while declaring package dependencies in nix.

To do this, a [[nix derivation]]  is an appropriate way of wrapping the `nvim` binary such that it always launches with your configuration.
```nix
{
  pkgs,
  name,
  version,
  ...
}: let
  lib = pkgs.lib;

  # Packages needed for running various functions (LSPs, etc)
  packages = with pkgs; [
    # Tools used by config
    ripgrep
    fd
    nodejs_22
    zoxide
    direnv
  ];

  # Nvim Plugins to make avalible
  plugins = with pkgs.vimPlugins; [
    lz-n
    gruvbox-nvim
    telescope-zoxide
  ];

  # Produce a valid vim packpath from the plugins list
  packpath = pkgs.runCommandLocal "packpath" {} ''
    mkdir -p $out/pack/${name}/{start,opt}

    ${
      lib.concatMapStringsSep
      "\n"
      (plugin: "ln -vsfT ${plugin} $out/pack/${name}/start/${lib.getName plugin}")
      plugins
    }
  '';
in
  pkgs.stdenv.mkDerivation {
    name = name;
    version = version;

    src = ./src;

    # Inputs for wrapping program
    nativeBuildInputs = with pkgs; [
      makeWrapper
    ];

    # This wrapper adds our plugins to the nevim package path
    # And points the configuration to the init.lua in ./src bundled 
    # With the derivation
    buildPhase = ''
      export NVIM_DIR=$out/bin
      mkdir -p $out/bin

      makeWrapper "${pkgs.neovim-unwrapped}/bin/nvim" $out/bin/${name} \
        --add-flags "--cmd 'set packpath^=${packpath} | set rtp^=${packpath}'" \
        --add-flags "--cmd 'set rtp^=$out/bin'" \
        --add-flags "-u '$out/bin/init.lua'" \
        --prefix PATH : ${lib.makeBinPath packages}
    '';

    installPhase = ''
      cp -r $src/* $out/bin
    '';
  }

```

This will effectively copy all files in `./src` into the neovim config directory, so you can put whatever you like in there to configure neovim.

---
### Lazy Loading
To quote the [README](https://github.com/nvim-neorocks/lz.n/blob/master/README.md) of [lz.n](https://github.com/nvim-neorocks/lz.n), our lazy loading plugin:

> It should be a plugin author's responsibility to ensure their plugin doesn't unnecessarily impact startup time, not yours!
> 
> Regardless, the current status quo is horrible, and some authors may not have the will or capacity to improve their plugins' startup impact.

As such it is common practice to lazy load plugins in neovim manually. Typically, a neovim user will use the [lazy package manager](https://github.com/folke/lazy.nvim) to achieve this, but we do not need a package manager so we will use [lz.n](https://github.com/nvim-neorocks/lz.n) for this purpose instead.

To summarise it's documentation, `lz.n` provides a simple plugin management API:
- Everything in `lua/plugins` (relative to `init.lua`) will be scanned for plugin declarations
- Plugins can be declared with an `event` which states when they will be loaded. Common events include:
	- `DeferredUIEnter` -> Load plugin after the UI has been loaded
	- `UIEnter` -> Load plugin before the UI is loaded
	- Other lesser used events can be read about by running `:h events` in editor
- Plugins declare an `after` callback for after the plugin is loaded where items such as creating key binds or configuring the plugin are performed.

Here is an example of my configuration for [oil.nvim](https://github.com/stevearc/oil.nvim):
```lua
return {
  'oil.nvim',
  event = 'DeferredUIEnter',
  after = function()
    require('oil').setup {
      default_file_explorer = true,
      prompt_save_on_select_new_entry = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
    }

    -- Enable navigating out of a file
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
```

---
### Full Configuration
The full configuration can be found [here](https://github.com/baileyluTCD/nixos-configuration/tree/master/packages/neovim), which has been documented to be the best of my ability. I recommend having a look over it, or trying it out with:
```bash
nix run github:baileyluTCD/nixos-configuration/?dir=packages/neovim
```

And launching either `neovide`, a [graphical frontend](https://neovide.dev/) or just plain `nvim`.


----
### See also
- [This tutorial](https://ayats.org/blog/neovim-wrapper) provides a more fully featured approach to making a custom nix powered nvim wrapper.