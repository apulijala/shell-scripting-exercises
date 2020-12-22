#!/bin/bash 
<<EOF
    Checking whether a process is still running
    Given a process ID (PID) as an argument, this script 
    will check, at user-specified intervals, whether 
    the given process is still running. You may use the 
    ps and sleep commands.
    for andrew. 
EOF

function check_process_still_running() {

    [ $#  -ne 1 ] && {
        echo "usage: check_process_still_running <pid>" 1>&2
        return 1
    }
    
    pid="$1"
    set -o pipefail
    while  ps -aef | awk '{print $2}' | grep "$pid"  
    do 
        echo "pid $pid is still running"
        sleep 5
    done
    set +o pipefail
    echo "pid $pid is not running now"
}







