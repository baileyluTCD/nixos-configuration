{...}: let
  theme = {
    black = "#282828";
    white = "#ebdbb2";
    red = "#fb4934";
    green = "#b8bb26";
    blue = "#83a598";
    yellow = "#fe8019";
    gray = "#a89984";
    darkgray = "#3c3836";
    lightgray = "#504945";
    inactivegray = "#7c6f64";
  };
  left_separator = fg: bg: "[](fg:${fg} bg:${bg})";
  right_separator = fg: bg: "[](fg:${fg} bg:${bg})";
in {
  programs.starship = with theme; {
    enable = true;
    settings = {
      format =
        "$shell"
        + left_separator theme.gray theme.lightgray
        + "$git_branch"
        + "$git_status"
        + left_separator theme.lightgray theme.darkgray
        + "$directory"
        + "$fill"
        + "$os"
        + right_separator theme.lightgray theme.darkgray
        + "$cmd_duration"
        + right_separator theme.gray theme.lightgray
        + "$time"
        + "$line_break";

      shell = {
        disabled = false;
        style = "fg:${theme.black} bg:${theme.gray}";
        format = "[ $indicator ]($style)";
      };

      git_branch = {
        symbol = "";
        style = "fg:${theme.white} bg:${theme.lightgray}";
        format = "[ $symbol $branch |]($style)";
      };

      git_status = {
        style = "fg:${theme.white} bg:${theme.lightgray}";
        format = "[ $all_status ]($style)";
      };

      directory = {
        style = "fg:${theme.gray} bg:${theme.darkgray}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = " 󰈙 ";
          "Downloads" = "  ";
          "Music" = "   ";
          "Pictures" = "   ";
        };
      };

      fill = {
        symbol = " ";
        style = "bg:${theme.darkgray}";
      };

      os = {
        disabled = false;
        style = "fg:${theme.gray} bg:${theme.darkgray}";
        format = "[ $symbol $name ]($style)";
      };

      time = {
        disabled = false;
        style = "fg:${theme.black} bg:${theme.gray}";
        format = "[ $time ]($style)";
      };

      cmd_duration = {
        style = "fg:${theme.white} bg:${theme.lightgray}";
        format = "[ $duration ]($style)";
      };

      character = {
        success_symbol = ":";
        error_symbol = "[:](bold red)";
      };
    };
  };
}
