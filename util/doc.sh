#!/usr/bin/env bash

help() {
    cat <<EOF
Supervisor: manager multiple programs by groups.
Usage: ./main.sh [COMMAND] [OPTION] [ARGS]...

COMMAND
    start       start programs by groups or names
    stop        start programs by groups or names
    status      print process running status by groups or names

OPTION
    -g          group, followed by multiple group names

ARGS            multiple group names or program names
EOF
}
