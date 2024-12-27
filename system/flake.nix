{
  description = "Flake containing core system configurations";

  inputs = {
  };

  outputs = {...}: {
    modules = [
      ./configuration.nix
    ];
  };
}
