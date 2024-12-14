{ preferences, ... }:

{
  imports = 
    if preferences.browser == "firefox" then [
      ./firefox.nix
    ]
    else [];
}

