This configuration separates the [[System Configuration]] and the [[Home Manager Configuration]] into separate [[Nix Flakes|flakes]] with a unifying [[Nix Flakes|flake]] for [[Global Configuration]].

Programs with a lot of configuration which do not make sense to be handled in the main system tree due to sheer size of configuration are placed in [[Package|packages]].

---
### Diagram
The mental model for this system should be something like the following:
 
 ```mermaid
 graph TD;
 A(Global Flake)
 B(System Configuration Flake)
 C(Home Manager Configuration Flake)
 D[(Packages)]
 
 A --> B;
 A --> C;
 
 D --> B;
 linkStyle 2 stroke-dasharray: 5,5 
 D --> C;
 linkStyle 3 stroke-dasharray: 5,5 
```