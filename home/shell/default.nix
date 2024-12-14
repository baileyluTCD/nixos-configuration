{ preferences, ... }:

{
  imports = 
    if preferences.shell == "nu" then [
      ./nushell.nix
    ]
    else [];
}
