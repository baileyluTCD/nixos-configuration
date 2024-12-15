This configuration separates the [[System Configuration]] and the [[Home Manager Configuration]] into separate [[Nix Flakes|flakes]] with a unifying [[Nix Flakes|flake]] for [[Global Configuration]].

> [!note]
> The mental model for this system should be something like the following:
> 
> ```mermaid
> graph TD;
> A(Global Flake)
> B(System Configuration Flake)
> C(Home Manager Configuration Flake)
> 
> A --> B;
> A --> C;
>```