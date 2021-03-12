#!/usr/bin/env bash

get_processes_by_name() {
    name="$1"
    group="$2"
    local pinfos

    pinfo=$(echo "$running_processes" | grep "$name")
    [ "$pinfo" ] && {
        # -r interpret \n
        while read -r line; do
            pinfos="$pinfos\n$name $group RUNNING $line"
        done < <(echo "$pinfo")
    } || {
        pinfos="$pinfos\n$name $group STOPPED NULL NULL NULL NULL"
    }

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
        awk -r -v cols=$(tput cols) -f "$AWK_OUT_PUT"
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
        awk -r -v cols=$(tput cols) -f "$AWK_OUT_PUT"
}
