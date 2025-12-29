#!/bin/bash

source "$HOME/.config/colors.sh"
source "$HOME/.config/icons.sh"
TMP="/tmp/drawing_state.txt"

render_item() {
  PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
  CHARGING=$(pmset -g batt | grep 'AC Power')
  #COLOR=$COLOR_YELLOW
  #local DRAWING=$(get_label_state)

  if [ $PERCENTAGE = "" ]; then
    exit 0
  fi

  case ${PERCENTAGE} in
  9[0-9] | 100)
    ICON=$BATTERY_100
    COLOR=$COLOR_GREEN
    LABEL=$COLOR_GREEN
    ;;
  [7-8][0-9])
    ICON=$BATTERY_75
    COLOR=$COLOR_GREEN
    LABEL=$COLOR_WHITE
    ;;
  [3-6][0-9])
    ICON=$BATTERY_50
    COLOR=$COLOR_YELLOW
    LABEL=$COLOR_WHITE
    ;;
  2[0-9])
    ICON=$BATTERY_25
    COLOR=$COLOR_YELLOW
    LABEL=$COLOR_WHITE
    DRAWING="on"
    ;;
  1[0-9])
    ICON=$BATTERY_0
    COLOR=$COLOR_RED
    LABEL=$COLOR_RED
    DRAWING="on"
    ;;
  *)
    ICON=$BATTERY_0
    COLOR=$COLOR_RED
    LABEL=$COLOR_RED
    DRAWING="on"
    ;;
  esac

  if [[ $CHARGING != "" ]]; then
    ICON=$BATTERY_CHARGING
  fi

  sketchybar --set $NAME icon=$ICON icon.color=$COLOR_WHITE label=$PERCENTAGE% label.color=$COLOR_WHITE label.drawing=on
}

save_label_state() {
  echo "$(sketchybar --query $NAME | jq -r '.label.drawing')" >"$TMP"
}

get_label_state() {
  if [ -e "$TMP" ]; then
    cat "$TMP"
  else
    echo "off" >"$TMP"
  fi
}

label_toggle() {
  if [[ $(get_label_state) == "on" ]]; then
    DRAWING="off"
  else
    DRAWING="on"
  fi

  sketchybar --set $NAME label.drawing=on
  save_label_state
}

case "$SENDER" in
"mouse.clicked")
  label_toggle
  ;;
"routine" | "forced" | "power_source_change")
  render_item
  ;;
esac
