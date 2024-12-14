let
  username = "luke";
in {
  # Trust myself to modify nix settings
  nix.settings.trusted-users = [username];

  # Define my personal user account so I don't have to login as root
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };

  # Export the main user as the primary user to login for, etc
  primary = username;
}
