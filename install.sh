#!/bin/bash

if [[ ! -d "$HOME/.config/alacritty/" ]]; then
  mkdir -p "$HOME/.config/alacritty/"
fi
VARIANTS=("dark" "light" "quit")
select variant in "${VARIANTS[@]}"; do
  case $variant in
    "dark")
      echo "Installing Isotope Dark theme to $HOME/.config/alacritty/alacritty.yml"
      curl -s https://raw.githubusercontent.com/Isotope-Theme/alacritty/master/isotope-dark.yml >> $HOME/.config/alacritty/alacritty.yml
      break
      ;;
    "light")
      echo "Installing Isotope Light theme to $HOME/.config/alacritty/alacritty.yml"
      curl -s https://raw.githubusercontent.com/Isotope-Theme/alacritty/master/isotope-light.yml >> $HOME/.config/alacritty/alacritty.yml
      break
      ;;
    "quit")
      break
      ;;
    *)
      echo "invalid variant $REPLY"
      ;;
  esac
done
