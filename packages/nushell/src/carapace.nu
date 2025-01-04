source ~/.cache/carapace/init.nu

let carapace_completer = {|spans|
  carapace $spans.0 nushell $spans | from json
}
