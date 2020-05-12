#!/bin/bash

if [[ ! -d "$HOME/.config/alacritty/" ]]; then
  mkdir -p "$HOME/.config/alacritty/"
fi
echo "Installing Isotope theme to $HOME/.config/alacritty/alacritty.yml"
curl -s https://raw.githubusercontent.com/Isotope-Theme/alacritty/master/isotope.conf >> $HOME/.config/alacritty/alacritty.yml
