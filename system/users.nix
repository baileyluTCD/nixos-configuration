{lib, ...}: let
  username = "luke";
in {
  options = {
    # Define a custom option for primary user
    users.primary = lib.mkOption {
      type = lib.types.str;
      default = username;
      description = "The primary user of the system";
    };
  };

  config = {
    # Trust the user to modify nix settings
    nix.settings.trusted-users = [username];

    # Enable sudo for the primary user
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable sudo for the user
    };

    # Export the primary user from the module
    users.primary = username;
  };
}
