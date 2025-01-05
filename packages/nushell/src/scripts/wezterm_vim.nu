# Emulate the vim ":sp" shortcut for splitting a wezterm pane horizontally
def sp [] {
  wezterm cli split-pane --bottom
}

# Emulate the vim ":vs" shortcut for splitting a wezterm pane vertically
def vs [] {
  wezterm cli split-pane --right
}

# Emulate the vim ":q" shortcut for closing
def q [] {
  wezterm cli kill-pane
}
