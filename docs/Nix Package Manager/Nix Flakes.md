This configuration makes heavy use of [Nix Flakes](https://nixos.wiki/wiki/flakes) in order to separate functionality and allow testing of modular blocks without running a whole system rebuild.

[Nix Flakes](https://nixos.wiki/wiki/flakes) are a similar concept to a [Rust Crate](https://doc.rust-lang.org/book/ch07-01-packages-and-crates.html) or a [Mix Elixir Project](https://hexdocs.pm/mix/1.12/Mix.html), in that they allow declarative declarations of dependencies that are pinned in a lock file.

---
### Structure
Nix flakes are structured with three specified sections:
- `description` -> A textual description of the flake's purpose
- `inputs` -> A list of input URLs of other flakes to draw from
- `outputs` -> The modules, attributes or executables produced from the flake.

> [!warning]
> While flakes end in a `.nix` extension much like regular files, they **are not** parsed as such, but with **specific flake parsing rules**. The error messages for this are **obtuse**, so watch out.
> 
> Inside the `outputs` section is the only area where normal language rules apply.