{ ... }:
{
  home.username = "luke";
  home.stateVersion = "24.11";

  programs.git = {
    enable = true;
    userName = "Luke Bailey";
    userEmail = "baileylu@tcd.ie";
  };

  programs.gh.enable = true;

  home.homeDirectory = "/home/luke";

  programs.home-manager.enable = true;
}
