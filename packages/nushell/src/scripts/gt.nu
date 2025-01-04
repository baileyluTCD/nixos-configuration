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
  print "Adding files..."
  git add .

  print "Committing changes..."
  git commit -m $message 
}

# Git [A]dd [C]ommit [P]ush
#
# Shorthand notation for staging all files and committing with a message, then pusing to the branch
def "gt acp" [
  message: string # The message to commit with
] {
  gt ac $message

  print "Pushing changes..."
  git push
}
