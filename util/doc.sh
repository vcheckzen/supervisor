#!/usr/bin/env bash

help() {
    cat <<EOF
Supervisor: manage multiple programs by groups.
Usage: ./main.sh [COMMAND] [OPTION] [ARGS]...

COMMAND
    start       start programs by groups or names
    stop        stop programs by groups or names
    status      print process running status by groups or names

OPTION
    -g          group, followed by a group name

ARGS            multiple groups or program names
EOF
}
