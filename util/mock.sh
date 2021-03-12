#!/usr/bin/env bash

source "./util.sh"

for group in $(get_config_items GROUP); do
    for prog in $(get_config_items "$group"); do
        for config in "$(get_config_items "$prog")"; do
            log=$(echo "$config" | awk '/parameters/ { print $2 }')
            [ -e "$log" ] || touch "../$log"
        done
    done
done
