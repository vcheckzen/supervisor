#!/usr/bin/env bash

get_config_items() {
    sed -nr \
        -e "/^\s*$/b;" \
        -e "/^\s*#/b;" \
        -e "/\[$1\]/,/\[/p" \
        "$CONFIG_FILE" |
        grep -v "\["
}

is_group_exists() {
    for gname in $(get_config_items GROUP); do
        [ "$gname" == "$1" ] && {
            return
        }
    done
    return 1
}

get_group_by_process_name() {
    for gname in $(get_config_items GROUP); do
        for pname in $(get_config_items "$gname"); do
            [ "$pname" == "$1" ] && {
                echo "$gname"
                return
            }
        done
    done
}

retrieve_running_processes() {
    # $# represents gapsgth of parameters
    # $0 represents name of this script
    # $$ represents pid of this script
    local pcmd="ps --no-headers -eo pid,pcpu,pmem,lstart,args"
    running_processes=$(
        eval "$pcmd" | grep -vE "($0|grep|$pcmd)"
    )
    export running_processes
}

gen_program_start_cmd() {
    get_config_items "$1" | awk -v FS== '
        /program/ { program = $2 }
        /parameters/ { parameters = $2 }
        END { print program " " parameters }
    '
}
