{pkgs, ...}: {
  home.packages = with pkgs; [
    zoxide
    neovim
    git
  ];

  programs = {
    nushell = {
      enable = true;
      configFile.source = ./src/config.nu;
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };

  home.file = {
    "nushell-config" = {
      source = ./src;
      target = ".config/nushell";
      recursive = true;
    };
  };
}
