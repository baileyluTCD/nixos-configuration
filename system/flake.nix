{
  description = "Flake containing core system configurations";

  inputs = {
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
  };

  outputs = {alejandra, ...}: {
    modules = [
      {
        environment.systemPackages = [alejandra.defaultPackage.x86_64-linux];
      }
      ./configuration.nix
    ];
  };
}
