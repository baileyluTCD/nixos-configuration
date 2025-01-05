{pkgs, ...}: {
  home.packages = with pkgs; [
    zoxide
    starship
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = builtins.readFile ./.zshrc;
  };
}
