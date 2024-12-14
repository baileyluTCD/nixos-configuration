{
  description = "Flake containing core system configurations";

  inputs = {
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    alejandra,
    ...
  }: {
    modules = [
      {
        environment.systemPackages = [alejandra.defaultPackage.x86_64-linux];
      }
      ./configuration.nix
    ];
  };
}
