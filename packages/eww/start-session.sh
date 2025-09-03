#!/usr/bin/env bash

while getopts 'pnh' opt; do
  case "$opt" in
    p)
      echo "Launcing programming session..."

      niri-unwrapped msg action focus-workspace 1
      niri-unwrapped msg action spawn -- librewolf
      sleep 1s
      niri-unwrapped msg action maximize-column

      niri-unwrapped msg action focus-workspace 2
      niri-unwrapped msg action spawn -- neovide
      sleep 1s
      niri-unwrapped msg action maximize-column

      niri-unwrapped msg action focus-workspace 3
      niri-unwrapped msg action spawn -- ghostty
      sleep 1s
      niri-unwrapped msg action maximize-column
      ;;

    n)
      echo "Launcing notes session..."

      niri-unwrapped msg action focus-workspace 1
      niri-unwrapped msg action spawn -- librewolf 
      niri-unwrapped msg action spawn -- obsidian
      ;;

    ?)
      echo "Usage: $(basename "$0") [-p] [-n]"
      exit 1
      ;;
  esac
done
shift "$((OPTIND -1))"
