{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "luke";
  home.homeDirectory = "/home/luke";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.git = {
    enable = true;
    userName = "Luke Bailey";
    userEmail = "baileylu@tcd.ie";
  };

  programs.gh.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.firefox.enable = true;
  programs.kitty.enable = true;

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$browser" = "firefox";
    "$launcher" = "wofi --show run";
    bind = [
      "$mod, B, exec, $browser"
      "$mod, T, exec, $terminal"
      "$mod, L, exec, $launcher"
      "$mod, K, killactive"
      "$mod, Q, exit"
      "ALT, H, movefocus, l"
      "ALT, J, movefocus, d"
      "ALT, K, movefocus, u"
      "ALT, L, movefocus, r"
      "$mod, 0, workspace, 10"
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
    ];
    exec-once = "waybar";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    waybar
    wofi
    nerdfonts
    font-awesome
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/luke/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
