In the context of this [[Architecture|configuration]] a _package_ is a group of [[Nix Module|modules]] which have been separated from the main configuration tree.

> [!info] Benefits
> This has a **number of benefits** for both ease of use and configuration:
> - Packages become their **own entities** and can be used anywhere which has nix installed with the `nix run <package url>` command
> - Small configuration changes become **much easier to test** when a full rebuild of the [[Architecture|system]] with `sudo nixos-rebuild switch` **does not** need to be done.

---
### Package Shells
All of the packages in the `packages/` directory are designed to be both:
- Importable as a set of modules into the main configuration
- Launchable as an isolated shell process which cleans up any changes made to the configuration afterwards
#### Home Manager Shell: Introduction
This can achieved through the incredibly useful [Home Manager Shell](https://discourse.nixos.org/t/home-manager-shell-nix-shell-for-your-home-manager-config/24632) tool, which allows for exactly this with module configurations in the style of [[Home Manager Configuration|home manager]].

In practice, this allows for a far **more general way** to achieve what projects like [nixvim](https://github.com/nix-community/nixvim) do for **testing configuration changes** with a temporary process started with `nix run .`. As you can imagine this allows other workflows such as:
- Configuring your window manager to look exactly the way you want
- Testing a bunch of UI widgets
- Fiddling with configuration options for language servers
entirely **without rebuilding the whole system**, which save significant amounts of time over the course of the configuration.

#### Flake Setup
An example flake which can achieve this may look like:
```nix
{
  description = "Flake exposing home manager config for neovim";

  inputs = {
	# Import the home-manager-shell flake library from it's github
    home-manager-shell.url = "github:dermetfan/home-manager-shell";
    home-manager.follows = "home-manager-shell/home-manager";
	
	# Import the flake-utils flake library from it's github
    flake-utils.follows = "home-manager-shell/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    home-manager-shell,
    ...
  }:
	# Execute code for every possible nix system
    flake-utils.lib.eachDefaultSystem (system: {
	  # Expose an application for running with `nix run .`
      apps.default = flake-utils.lib.mkApp {
        drv = home-manager-shell.lib {
          inherit self system;
		  
		  # Optional home manager extra special args
		  # These can be whatever you want and are
		  # Passed into any modules in your setup as
		  # arguements
          args.extraSpecialArgs.neovimStyle = "gruvbox";
        };
      };
    })
    
	# Expose the modules to the public to allow them to be
	# Imported later
    // rec {
      modules = ./default.nix;
      homeManagerProfiles.luke = modules;
    };
}
```