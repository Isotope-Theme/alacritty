#!/bin/bash

# Common {{{
LOCAL=0
if [[ -d ".git" ]] && hash git 2>/dev/null; then
  remote=$(git remote get-url origin 2>/dev/null)
  [[ "$remote" == *"Isotope-Theme/alacritty"* ]] && LOCAL=1
fi

VARIANTS=("dark" "light" "quit")
VARIANT=""
select variant in "${VARIANTS[@]}"; do
  case $variant in
    "dark"|"light")
      VARIANT=$variant
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
[[ -z "$VARIANT" ]] && exit 0

CONTRASTS=("soft" "medium" "hard" "quit")
CONTRAST=""
select contrast in "${CONTRASTS[@]}"; do
  case $contrast in
    "soft"|"medium"|"hard")
      CONTRAST=$contrast
      break
      ;;
    "quit")
      break
      ;;
    *)
      echo "invalid contrast $REPLY"
      ;;
  esac
done
[[ -z "$CONTRAST" ]] && exit 0
# }}}

CONFIG_FILES=("$XDG_CONFIG_HOME/alacritty/alacritty.yml" "$XDG_CONFIG_HOME/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml" "$HOME/.alacritty.yml")
CONFIG_FENCE=("# Isotope Theme - Begin" "# Isotope Theme - End")

CONFIG_FILE="${CONFIG_FILES[0]}"
for file in "${CONFIG_FILES[@]}"; do
  [[ -f "$file" ]] && CONFIG_FILE="$file" && break
done

[[ ! -d "$(dirname $CONFIG_FILE)" ]] && mkdir -p "$(dirname $CONFIG_FILE)"
[[ ! -f "$CONFIG_FILE" ]] && touch "$CONFIG_FILE"

echo "Installing Isotope $VARIANT-$CONTRAST theme to $CONFIG_FILE"

if [[ $LOCAL == 1 ]]; then
  SOURCE=$(cat "isotope-$VARIANT-$CONTRAST.yml")
else
  SOURCE=$(curl -s "https://raw.githubusercontent.com/Isotope-Theme/alacritty/master/isotope-$VARIANT-$CONTRAST.yml")
fi
if grep -Fxq "${CONFIG_FENCE[0]}" "$CONFIG_DIR/$CONFIG_FILE"; then
  SOURCE=$(sed ':a;N;$!ba;s/\n/\\n/g' <<< "$SOURCE")
  sed -i "/${CONFIG_FENCE[0]}/,/${CONFIG_FENCE[1]}/c$SOURCE" "$CONFIG_FILE"
else
  echo "$SOURCE" >> "$CONFIG_FILE"
fi
