{pkgs, ...}: {
  packages = with pkgs; [
    nil
    lua-language-server
  ];
}
