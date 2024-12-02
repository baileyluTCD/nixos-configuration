{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./starship.nix
    ./carapace.nix
  ];

  programs.nushell = with config.colorScheme.palette; {
    enable = true;
    # for editing directly to config.nu
    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
      }

      $env.config = {
        show_banner: false,
        completions: {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: "fuzzy"
          external: {
            enable: true
            max_results: 100
            completer: $carapace_completer
          }
        }
        color_config: {
          leading_trailing_space_bg: "#${base03}"
          header: "#${base0B}"
          empty: "#${base0C}"
          row_index: "#${base09}"
          hints: "#${base0F}"
          shape_filepath: "#${base0E}"
          shape_string: "#${base0D}"
          shape_bool: "#${base0A}"
          shape_external: "#${base04}"
          shape_externalarg: "#${base0D}"
        }
      }

      $env.PATH = (
        $env.PATH |
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
      )

      zoxide init nushell | save -f ~/.zoxide.nu
    '';

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };
}
