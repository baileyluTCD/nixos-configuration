The _system configuration_ is a set of [[Nix Module|modules]] that **declaratively** define system level configuration for stuff like installed drivers, packages needed for all users, networking, etc.

---
### Packages
Packages can be installed without configuration with `environment.systemPackages`:

```nix
{pkgs, ...}: {
	environment.systemPackages = with pkgs; [
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
### System settings
There are many **system level configuration options** available in nix used for many settings from firewalls to display servers.

For example, configuring some locality settings might look like:
```nix
  # Set your time zone
  time.timeZone = "Europe/Dublin";

  # Set language locale
  i18n.defaultLocale = "en_IE.UTF-8";

  # Set keyboard type used
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };
```

A full list of options can be found [here](https://nixos.org/manual/nixos/stable/options.html).

