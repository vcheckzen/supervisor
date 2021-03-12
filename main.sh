#!/usr/bin/env bash

CONFIG_FILE="./programs.cfg"
AWK_OUT_PUT="./util/output.awk"

[ -e "$CONFIG_FILE" ] || {
    echo "Config file: [$CONFIG_FILE] does not exist."
    exit 1
}

source "./util/doc.sh"
source "./util/util.sh"
source "./util/start.sh"
source "./util/stop.sh"
source "./util/status.sh"

retrieve_running_processes
case $1 in
start)
    case $2 in
    "")
        start_programs_by_groups $(get_config_items GROUP)
        retrieve_running_processes
        print_processes_by_groups $(get_config_items GROUP)
        ;;
    -g)
        shift
        shift
        start_programs_by_groups "$@"
        retrieve_running_processes
        print_processes_by_groups "$@"
        ;;
    *)
        shift
        start_programs_by_names "$@"
        retrieve_running_processes
        print_processes_by_names "$@"
        ;;
    esac
    ;;
stop)
    case $2 in
    "")
        stop_programs_by_groups $(get_config_items GROUP)
        retrieve_running_processes
        print_processes_by_groups $(get_config_items GROUP)
        ;;
    -g)
        shift
        shift
        stop_programs_by_groups "$@"
        retrieve_running_processes
        print_processes_by_groups "$@"
        ;;
    *)
        shift
        stop_programs_by_names "$@"
        retrieve_running_processes
        print_processes_by_names "$@"
        ;;
    esac
    ;;
status)
    case $2 in
    "")
        print_processes_by_groups $(get_config_items GROUP)
        ;;
    -g)
        shift
        shift
        print_processes_by_groups "$@"
        ;;
    *)
        shift
        print_processes_by_names "$@"
        ;;
    esac
    ;;
*)
    help
    ;;
esac
