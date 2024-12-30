The file `global-config.nix` is a [[Nix Module|module]] loaded by the very [[Architecture|outermost]] [[Nix Flakes|flake]] which contains various **global options**.

These include stuff like settings for [nixpkgs](https://github.com/NixOS/nixpkgs) like `allowUnfree` which allows the use of packages without a **free licence** like [Obsidian](https://search.nixos.org/packages?channel=24.11&show=obsidian&from=0&size=50&sort=relevance&type=packages&query=obsidian).
