#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

get_weather() {
  https GET api.open-meteo.com/v1/forecast \
    latitude==37.1905 \
    longitude==-93.3753 \
    current=="temperature_2m,weather_code" \
    temperature_unit==fahrenheit \
    wind_speed_unit==mph \
    precipitation_unit==inch | jq
}

update_weather() {
  local update_interval=$((60 * $(get_tmux_option "@weather-interval" 5)))
  local current_time=$(date "+%s")
  local previous_update=$(get_tmux_option "@weather-previous-update-time")
  local delta=$((current_time - previous_update))

  if [ -z "$previous_update" ] || [ $delta -ge $update_interval ]; then
    local weather=$(get_weather)

    local weatherText="$(echo $weather | jq -r '.current.temperature_2m')$(echo $weather | jq -r '.current_units.temperature_2m')"
    local weatherCode=$(echo $weather | jq -r '.current.weather_code')
    local weatherIcon=" "
    case $weatherCode in
      # https://open-meteo.com/en/docs/api/available-weather-codes
      # Clear Sky
      0 | 1) weatherIcon="󰖙" ;;
      # Partly Cloudy, Overcast
      2 | 3) weatherIcon="󰖕" ;;
      # Fog
      45 | 48) weatherIcon="󰖑" ;;
      # Drizzle
      51 | 53 | 55) weatherIcon="󰖗" ;;
      # Freezing Drizzle
      56 | 57) weatherIcon="󰙿" ;;
      # Rain
      61 | 63) weatherIcon="󰖗" ;;
      65) weatherIcon="󰖖" ;;
      # Freezing Rain
      66 | 67) weatherIcon="󰙿" ;;
      # Snow
      71 | 73) weatherIcon="󰖘" ;;
      75 | 77) weatherIcon="󰼶" ;;
      # Rain Showers
      80 | 81 | 82) weatherIcon="󰖗" ;;
      # Snow Showers
      85 | 86) weatherIcon="󰖘" ;;
      # Thunderstorms
      95 | 96 | 99) weatherIcon="󰖓" ;;
    esac

    if [ "$?" -eq 0 ]; then
      $(set_tmux_option "@weather-previous-update-time" "$current_time")
      $(set_tmux_option "@weather-previous-value" "$weatherText")
      $(set_tmux_option "@weather-previous-icon" "$weatherIcon")
    fi
  fi
}

main() {
  local arg=$1

  update_weather
  case $arg in
    icon)
      echo -n $(get_tmux_option "@weather-previous-icon")
      return 0
      ;;
    text)
      echo -n $(get_tmux_option "@weather-previous-value")
      return 0
      ;;
  esac
}

main "$@"
