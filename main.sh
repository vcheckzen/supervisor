#!/usr/bin/env bash

BASE_DIR=$(dirname "$0")
export BASE_DIR

CONFIG_FILE="$BASE_DIR/programs.cfg"
# shellcheck disable=SC2034
AWK_OUT_PUT="$BASE_DIR/util/output.awk"

[ -e "$CONFIG_FILE" ] || {
    echo "Config file: [$CONFIG_FILE] does not exist."
    exit 1
}

# shellcheck disable=SC1091
source "$BASE_DIR/util/doc.sh"
# shellcheck disable=SC1091
source "$BASE_DIR/util/util.sh"
# shellcheck disable=SC1091
source "$BASE_DIR/util/start.sh"
# shellcheck disable=SC1091
source "$BASE_DIR/util/stop.sh"
# shellcheck disable=SC1091
source "$BASE_DIR/util/status.sh"

retrieve_running_processes
case $1 in
start)
    case $2 in
    "")
        # shellcheck disable=SC2046
        start_programs_by_groups $(get_config_items GROUP)
        retrieve_running_processes
        # shellcheck disable=SC2046
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
        # shellcheck disable=SC2046
        stop_programs_by_groups $(get_config_items GROUP)
        retrieve_running_processes
        # shellcheck disable=SC2046
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
        # shellcheck disable=SC2046
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
mock)
    # shellcheck disable=SC1091
    source "$BASE_DIR/util/mock.sh"
    ;;
*)
    help
    ;;
esac
