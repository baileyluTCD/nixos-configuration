{preferences, ...}: {
  programs.git = {
    enable = true;
    userName = preferences.name;
    userEmail = preferences.email;
  };
}
