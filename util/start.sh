#!/usr/bin/env bash

start_program_by_name() {
    local name="$1"
    local start_cmd
    start_cmd=$(gen_program_start_cmd "$name")
    # shellcheck disable=SC2154
    echo "$running_processes" | grep -q "$start_cmd" && {
        echo "Provided program: [$name] already started."
        return 1
    }
    eval "nohup $start_cmd &>/dev/null &"
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
    # shellcheck disable=SC2046
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
