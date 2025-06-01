#!/usr/bin/env bash

i3-msg -t subscribe -m '["window","workspace"]' | while read -r event; do
    current_ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')
    window_title=$(i3-msg -t get_tree | jq -r '.. | select(.focused? == true) | .name' | head -1)
    
    if [ ! -z "$window_title" ]; then
        ws_num=$(echo $current_ws | grep -o '^[0-9]*')
        i3-msg "rename workspace to \"$ws_num: $window_title\""
    fi
done
