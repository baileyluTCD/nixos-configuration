# Git Helper Utility Scripts
#
# Provides shorthand notation for common git tasks
def gt [] {
  echo "
    Git Helper Utility Scripts

    Try `gt --help` for more information
  "
}

# Git [A]dd [C]ommit
#
# Shorthand notation for staging all files and committing with a message
def "gt ac" [
  message: string # The message to commit with
] {
  print $'(ansi green_bold)Adding files...(ansi reset)'
  git add .

  print $'(ansi green_bold)Committing changes...(ansi reset)'
  git commit -m $message 
}

# Git [A]dd [C]ommit [P]ush
#
# Shorthand notation for staging all files and committing with a message, then pusing to the branch
def "gt acp" [
  message: string # The message to commit with
] {
  gt ac $message

  print $'(ansi green_bold)Pushing changes...(ansi reset)'
  git push
}
