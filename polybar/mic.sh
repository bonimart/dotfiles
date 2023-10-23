#!/bin/sh

if [ "$(pactl get-source-mute @DEFAULT_SOURCE@)" = "Mute: no" ]
then 
    echo ""
else
    echo ""
fi
