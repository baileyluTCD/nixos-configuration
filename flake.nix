{
  description = "Root configuration flake importing both home-manager config and system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    rofi-wifi-menu = {
      url = "github:zbaylin/rofi-wifi-menu";
      flake = false;
    };
  };

  outputs = inputs: inputs.blueprint {inherit inputs;};
}
