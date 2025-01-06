{pkgs, ...}: {
  imports = [
    ./starship.nix
  ];

  home.packages = with pkgs; [
    zoxide
    git
    fastfetch
  ];

  home.file = {
    "nushell-config" = {
      source = ./src;
      target = ".nushell";
      recursive = true;
    };
  };

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
}
