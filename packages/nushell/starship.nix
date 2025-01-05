{...}: let
  theme = {
    shell = {
      foreground = "282828";
      background = "bdae93";
    };
    directory = {
      foreground = "665c54";
      background = "ebdbb2";
    };
    git = {
      foreground = "b8bb26";
      background = "665c54";
    };
    language = {
      foreground = "8ec07c";
      background = "504945";
    };
    time = {
      foreground = "83a598";
      background = "3c3836";
    };
    character = {
      success = "bdae93";
      error = "fb4934";
    };
  };
  language_style_format = with theme.language; {
    style = "bg:#${background}";
    format = "[[ $symbol ($version) ](fg:#${foreground} bg:#${background})]($style)";
  };
in {
  programs.starship = with theme; {
    enable = true;
    settings = {
      format =
        "$shell"
        + "[](fg:#${shell.background} bg:#${directory.background})"
        + "$directory"
        + "[](fg:#${directory.background} bg:#${git.background})"
        + "$git_branch"
        + "$git_status"
        + "[](fg:#${git.background} bg:#${language.background})"
        + "$nodejs"
        + "$rust"
        + "$golang"
        + "$c"
        + "$java"
        + "$lua"
        + "$nix_shell"
        + "[](fg:#${language.background} bg:#${time.background})"
        + "$time"
        + "[ ](fg:#${time.background})\n$character";

      directory = {
        style = "fg:#${directory.foreground} bg:#${directory.background}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      directory.substitutions = {
        "Documents" = " 󰈙 ";
        "Downloads" = "  ";
        "Music" = "   ";
        "Pictures" = "   ";
      };

      shell = {
        disabled = false;
        style = "fg:#${shell.foreground} bg:#${shell.background}";
        format = "[ $indicator ]($style)";
      };

      git_branch = {
        symbol = "";
        style = "bg:#${git.background}";
        format = "[[ $symbol $branch ](fg:#${git.foreground} bg:#${git.background})]($style)";
      };
      git_status = {
        style = "bg:#${git.background}";
        format = "[[($all_status$ahead_behind )](fg:#${git.foreground} bg:#${git.background})]($style)";
      };

      nodejs =
        {
          symbol = "";
        }
        // language_style_format;
      rust =
        {
          symbol = "";
        }
        // language_style_format;
      golang =
        {
          symbol = "󰟓";
        }
        // language_style_format;
      c =
        {
          symbol = "";
        }
        // language_style_format;
      java =
        {
          symbol = "";
        }
        // language_style_format;
      lua =
        {
          symbol = "";
        }
        // language_style_format;
      nix_shell =
        {
          symbol = "󱄅";
        }
        // language_style_format;

      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#${time.background}";
        format = "[[  $time ](fg:#${time.foreground} bg:#${time.background})]($style)";
      };

      character = {
        success_symbol = "[ 󰐊](#${character.success})";
        error_symbol = "[ 󰐊](#${character.error})";
      };
    };
  };
}
