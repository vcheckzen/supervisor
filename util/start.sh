#!/usr/bin/env bash

start_program_by_name() {
    name="$1"
    for config in "$(get_config_items "$name")"; do
        start_cmd=$(echo "$config" | awk -v FS== '
            /program/ { program = $2 }
            /parameters/ { parameters = $2 }
            END { print program " " parameters }
        ')
        [ "$(echo "$running_processes" | grep "$start_cmd")" ] && {
            echo "Provided program: [$name] already started."
            continue
        }
        eval "nohup $start_cmd &>/dev/null &"
    done
}

start_programs_by_names() {
    for name in "$@"; do
        group=$(get_group_by_process_name "$name")
        [ "$group" ] || {
            echo "Provided program: [$name] is not in config file."
            continue
        }
        start_program_by_name "$name"
    done
}

start_programs_by_group() {
    start_programs_by_names $(get_config_items "$1")
}

start_programs_by_groups() {
    for group in "$@"; do
        is_group_exists "$group" || {
            echo "Provided group: [$group] is not in config file."
            continue
        }
        start_programs_by_group "$group"
    done
}
