{ config, pkgs, ... }:

{
   programs.nushell = { 
      enable = true;
      # for editing directly to config.nu 
      extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell $spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/myuser/.apps |
       append /usr/bin/env
       )
       '';
       shellAliases = {
         vi = "hx";
         vim = "hx";
         nano = "hx";
       };
   };  

   programs.carapace.enable = true;
   programs.carapace.enableNushellIntegration = true;

   programs.starship = { 
       enable = true;
       settings = {
         format = "[░▒▓](#a3aed2)[ 󱄅 ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$clang$java$lua$nu$nix[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)\n$character";
	 directory = {
	   style = "fg:#e3e5e5 bg:#769ff0";
	   format = "[ $path ]($style)";
	   truncation_length = 3;
	   truncation_symbol = "…/";
	 };
	 directory.substitutions = {
	   "Documents" = "󰈙 ";
	   "Downloads" = " ";
	   "Music" = " ";
	   "Pictures" = " ";
	 };
	 git_branch = {
	   symbol = "";
	   style = "bg:#394260";
	   format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
	 };
	 git_status = {
	   style = "bg:#394260";
	   format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
	 };
	 nodejs = {
	   symbol = "";
	   style = "bg:#212736";
	   format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
	 };
	 rust = {
	   symbol = "";
	   style = "bg:#212736";
	   format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
	 };
	 golang = {
	   symbol = "";
	   style = "bg:#212736";
	   format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
	 };
	 php = {
	   symbol = "";
	   style = "bg:#212736";
	   format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
	 };
	 time = {
	   disabled = false;
	   time_format = "%R"; # Hour:Minute Format
	   style = "bg:#1d2230";
	   format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
	 };
       };
    };
}
