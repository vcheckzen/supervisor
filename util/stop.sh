#!/usr/bin/env bash

stop_program_by_name() {
    name="$1"
    for config in "$(get_config_items "$name")"; do
        start_cmd=$(echo "$config" | awk -v FS== '
            /program/ { program = $2 }
            /parameters/ { parameters = $2 }
            END { print program " " parameters }
        ')
        stop_cmd=$(
            echo "$running_processes" |
                grep "$start_cmd" |
                awk '{ print "kill -9 " $1 }'
        )
        [ "$stop_cmd" ] || {
            echo "Provided program: [$name] hasn't started."
            continue
        }
        eval "$stop_cmd"
    done
}

stop_programs_by_names() {
    for name in "$@"; do
        group=$(get_group_by_process_name "$name")
        [ "$group" ] || {
            echo "Provided program: [$name] is not in config file."
            continue
        }
        stop_program_by_name "$name"
    done
}

stop_programs_by_group() {
    stop_programs_by_names $(get_config_items "$1")
}

stop_programs_by_groups() {
    for group in "$@"; do
        is_group_exists "$group" || {
            echo "Provided group: [$group] is not in config file."
            continue
        }
        stop_programs_by_group "$group"
    done
}
