{ config, ... }:

let 
  theme = with config.colorScheme.palette; {
    logo = {
      foreground = base00;
      background = base04;
    };
    directory = {
      foreground = base03;
      background = base06;
    };
    git = {
      foreground = base0B;
      background = base03;
    };
    language = {
      foreground = base0C;
      background = base02;
    };
    time = {
      foreground = base0D;
      background = base01;
    };
  };
  language_style_format = with theme.language; {
    style = "bg:#${background}";
    format = "[[ $symbol ($version) ](fg:#${foreground} bg:#${background})]($style)";
  }; 
in
{

   programs.starship = with theme; { 
       enable = true;
       settings = {
         format = "[░▒▓](#${logo.background})[ 󱄅 ](bg:#${logo.background} fg:#${logo.foreground})[](fg:#${logo.background} bg:#${directory.background})$directory[](fg:#${directory.background} bg:#${git.background})$git_branch$git_status[](fg:#${git.background} bg:#${language.background})$nodejs$rust$golang$c$java$lua$nix_shell[](fg:#${language.background} bg:#${time.background})$time[ ](fg:#${time.background})\n$character";

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

	 git_branch = {
	   symbol = "";
	   style = "bg:#${git.background}";
	   format = "[[ $symbol $branch ](fg:#${git.foreground} bg:#${git.background})]($style)";
	 };
	 git_status = {
	   style = "bg:#${git.background}";
	   format = "[[($all_status$ahead_behind )](fg:#${git.foreground} bg:#${git.background})]($style)";
	 };

	 nodejs = {
	   symbol = "";
	 } // language_style_format;
	 rust = {
	   symbol = "";
	 } // language_style_format;
	 golang = {
	   symbol = "󰟓";
	 } // language_style_format;
	 c = {
	   symbol = "";
	 } // language_style_format;
	 java = {
	   symbol = "";
	 } // language_style_format;
	 lua = {
	   symbol = "";
	 } // language_style_format;
	 nix_shell = {
	   symbol = "󱄅";
	 } // language_style_format;

	 time = {
	   disabled = false;
	   time_format = "%R"; # Hour:Minute Format
	   style = "bg:#${time.background}";
	   format = "[[  $time ](fg:#${time.foreground} bg:#${time.background})]($style)";
	 };
       };
    };
}
