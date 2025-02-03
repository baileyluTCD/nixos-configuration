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
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
      if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
      }
    }]
  }
}

macchina
