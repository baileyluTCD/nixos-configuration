{ preferences, ... }:

{
  imports = 
    if preferences.editor == "nvim" then [
      ./neovim.nix
    ]
    else [];
}
