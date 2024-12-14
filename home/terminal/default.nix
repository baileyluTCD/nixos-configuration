{ preferences, ... }:

{
  imports = 
    if preferences.terminal.program == "kitty" then [
      ./kitty.nix
    ]
    else [];
}
