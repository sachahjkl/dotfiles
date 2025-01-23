#!/bin/sh
set -e

execCommand=$1
filter=$2

running=$(hyprctl -j clients | jq -r '.[] | select(.class | test($a)) | .title' --arg a "$filter" )
echo $running

if [[ $running != "" ]]
then
    echo "focus"
    hyprctl dispatch focuswindow "title:$running"
else 
    echo "start"
    ${execCommand} &
fi
