const NU_LIB_DIRS = [
  '~/.nushell'
]

source ./integrations/init.nu
source ./scripts/init.nu

source ./aliases.nu

use theme.nu gruvbox_theme

$env.config = {
  show_banner: false
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
  edit_mode: vi
  color_config: $gruvbox_theme
  buffer_editor: nvim
}

freshfetch
