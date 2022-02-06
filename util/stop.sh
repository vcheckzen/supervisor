#!/usr/bin/env bash

stop_program_by_name() {
    local name="$1"
    local stop_cmd
    # shellcheck disable=SC2154
    stop_cmd=$(
        echo "$running_processes" |
            grep "$(gen_program_start_cmd "$name")" |
            awk '{ print "kill -9 " $1 }'
    )
    [ "$stop_cmd" ] || {
        echo "Provided program: [$name] hasn't started."
        return 1
    }
    eval "$stop_cmd"
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
    # shellcheck disable=SC2046
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
