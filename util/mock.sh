#!/usr/bin/env bash

# shellcheck disable=SC1091
source "$BASE_DIR/util/util.sh"

[ -d "$BASE_DIR/log" ] || mkdir "$BASE_DIR/log"

for group in $(get_config_items GROUP); do
    for prog in $(get_config_items "$group"); do
        log=$(get_config_items "$prog" | awk '/parameters/ { print $2 }')
        [ -e "$log" ] || touch "$BASE_DIR/$log"
    done
done
