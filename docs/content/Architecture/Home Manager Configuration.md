The _[home manager](https://github.com/nix-community/home-manager)_ is a set of [[Nix Module|modules]] that **declaratively** define per user configuration for stuff like installed programs and packages.

---
### Packages
Packages can be installed without configuration with `home.packages`:
```nix
{pkgs, ...}: {
	home.packages = with pkgs; [
		cowsay
	];
}
```

---
### Configurable Programs
Many packages are available as `programs` with their own **config options handled by nix** which are then translated into the native configuration language ([JSON](https://en.wikipedia.org/wiki/JSON), [TOML](https://toml.io/en/), etc).
```nix
# Enable gnu privacy guard
# https://gnupg.org/
programs.gnupg.agent = {
	enable = true;
	enableSSHSupport = true;
};
```

---
### Home settings
There are many **user level configuration options** available in _[home manager](https://github.com/nix-community/home-manager)_ used for many settings from calendars to environment variables.

For example, configuring some user settings might look like:
```nix
home.username = "luke";
home.homeDirectory = "/home/luke";
home.stateVersion = "24.11";
```
A full list of options can be found [here](https://nix-community.github.io/home-manager/options.xhtml).

