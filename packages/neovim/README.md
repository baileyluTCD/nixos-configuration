# Neovim Configuration

This package represents my full neovim configuration.

# Documentation

Read the documentation for this setup [here](https://baileylutcd.github.io/nixos-configuration/Packages/Neovim).

# Try it out

Try out this setup with:

```bash
nix run github:baileyluTCD/nixos-configuration/?dir=packages/neovim
```

And launching either `neovide`, a [graphical frontend](https://neovide.dev/) or just plain `nvim`.

# Usage in a flake

Import this package in a flke as follows:

```nix
nvim.url = "github:baileyluTCD/nixos-configuration/?dir=packages/neovim";
```

Include it in a home manager configuration as follows:

```nix
home-manager.nixosModules.home-manager
{
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.luke = {
        imports = [
            ./home.nix
            nvim.modules
        ];
    };

    home-manager.extraSpecialArgs = {
        inherit pkgs;
        inherit nix-colors preferences system;
        inherit inputs;
    };
}
```
