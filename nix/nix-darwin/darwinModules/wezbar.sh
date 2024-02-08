#!/bin/bash

windows=$(yabai -m query --windows)
wezterm=$(echo $windows | jq -r '[.[] | select(.app == "WezTerm")][0]')
weztermid=$(echo $wezterm | jq -r '.id')

hasfocus=$(echo $wezterm | jq -r '.["has-focus"]')

if [ "$hasfocus" = "true" ]; then
  # yabai -m window $weztermid --grid 1:1:0:0:1:1
  # yabai -m window $weztermid --focus
  skhd -k 'cmd -h'
  exit
fi

# displays=$(yabai -m query --displays)
# display=$(echo $displays | jq -r '[.[] | select(.frame.x == 0)][0] | .frame')
# height=$(echo $display | jq -r '.h | tonumber | floor')
# width=$(echo $display | jq -r '.w | tonumber | floor')

# yabai -m window $wezterm --move abs:5:29
# yabai -m window $wezterm --resize abs:$((width-10)):$((height-34))

yabai -m window $weztermid --grid 1:1:0:0:1:1
yabai -m window $weztermid --focus
