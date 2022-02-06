#!/usr/bin/env bash

get_processes_by_name() {
    local name="$1"
    local group="$2"
    local pinfos

    # shellcheck disable=SC2154
    pinfo=$(echo "$running_processes" | grep "$(gen_program_start_cmd "$name")")
    if [ "$pinfo" ]; then
        # -r interpret \n
        while read -r line; do
            pinfos="$pinfos\n$name $group RUNNING $line"
        done < <(echo "$pinfo")
    else
        pinfos="$pinfos\n$name $group STOPPED NULL NULL NULL NULL"
    fi

    echo -n "${pinfos#*\n}"
}

print_processes_by_names() {
    local pinfos
    for name in "$@"; do
        group=$(get_group_by_process_name "$name")
        [ "$group" ] || {
            echo "Provided program: [$name] is not in config file."
            continue
        }
        pinfos="$pinfos\n$(get_processes_by_name "$name" "$group")"
    done

    echo -ne "${pinfos#*\n}" |
        awk -v cols="$(tput cols)" -f "$AWK_OUT_PUT"
}

get_processes_by_group() {
    local pinfos
    for pname in $(get_config_items "$1"); do
        pinfos="$pinfos\n$(get_processes_by_name "$pname" "$1")"
    done
    echo -n "${pinfos#*\n}"
}

print_processes_by_groups() {
    local pinfos
    for gname in "$@"; do
        processes=$(get_processes_by_group "$gname")
        [ "$processes" ] || {
            echo "Provided group: [$gname] is not in config file."
            continue
        }
        pinfos="$pinfos\n$processes"
    done

    echo -ne "${pinfos#*\n}" |
        awk -v cols="$(tput cols)" -f "$AWK_OUT_PUT"
}
