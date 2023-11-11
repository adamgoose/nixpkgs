#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_weather() { # save this module in a file with the name weather.sh
  local index=$1 # this variable is used by the module loader in order to know the position of this module 

  local script="$CURRENT_DIR/scripts/get-weather.sh"
  
  local icon="$(get_tmux_option "@catppuccin_weather_icon" "#($script icon)")"
  local color="$(get_tmux_option "@catppuccin_weather_color" "$thm_orange")"
  local text="$(get_tmux_option "@catppuccin_weather_text" "#($script text)")"

  local module=$( build_status_module "$index" "$icon" "$color" "$text" )
  echo "$module"
}
