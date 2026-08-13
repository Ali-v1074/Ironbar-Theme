#!/bin/bash

# Get battery info using upower
BATTERY=$(upower -e | grep 'BAT' | head -n1)

if [ -z "$BATTERY" ]; then
    echo "󰂃"
    exit 0
fi

# Get battery state and percentage
BatteryInfo=$(upower -i "$BATTERY")
State=$(echo "$BatteryInfo" | awk -F: '/state/ {gsub(" ","",$2); print $2}')
Percentage=$(echo "$BatteryInfo" | awk -F: '/percentage/ {gsub(" ","",$2); print $2}')

# Remove the % sign for comparison
PercentNum=${Percentage%?}

# Select battery icon based on percentage
if [ "$PercentNum" -ge 81 ]; then
    Icon="  "
elif [ "$PercentNum" -ge 56 ]; then
    Icon="  "
elif [ "$PercentNum" -ge 31 ]; then
    Icon="  "
elif [ "$PercentNum" -ge 11 ]; then
    Icon="  "
else
    Icon="  "
fi

# Check if charging
if [ "$State" = "charging" ] || [ "$State" = "fully-charged" ] || [ "$State" = "pending-charge" ]; then
    ChargingIcon="󱐋"
else
    ChargingIcon=""
fi

# Output plain text (no span tags)
echo "${Icon}${ChargingIcon} ${Percentage}"
