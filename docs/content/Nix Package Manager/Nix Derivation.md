A _nix derivation_ is a set of instructions used in order to realise a nix package.

---
### Benefits
- Fully declarative and pure configuration of packages
- Simple architecture for wrapping/building binaries that can scale to apps of any scale
- Pure Development Shells

---
### Example
Here is a captured version of the derivation I use to apply my [starship](https://starship.rs/) config:
```nix
{
  pkgs,
  name,
  version,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = name;
  version = version;

  src = ./starship.toml;

  unpackPhase = ":";

  # Inputs for wrapping program
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  buildPhase = ''
    mkdir -p $out/bin

    makeWrapper "${pkgs.starship}/bin/starship" $out/bin/${name} \
      --set STARSHIP_CONFIG $src
    '';
}
```