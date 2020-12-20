#!/bin/bash 
<<EOF
    Backup
    Archive as a "tarball" (*.tar.gz file) all 
    the files in your home directory 
    tree (/home/your-name) that have 
    been modified in the last 24 hours. 
    Hint: use find.

    Optional: you may use this as the basis 
    of a backup script.
EOF

# happening because of global variable. 
function log() {

    logfile="$1"
    # local declaration is important. 
    local dir="${logfile%/*}" #  Get the directory. 
    if [[ "$dir" = "$logfile" ]]
    then 
        dir="."
    fi 
    if [[ ! -r "$dir" || ! -w "$dir" ]]
    then 
        echo "$dir should  be readable or writable" 1>&2
        return 1
    fi 
    # extract this as 
    [[ ! -f "$logfile" ]] && {
        touch "$logfile"
    }
    # That is why it is not being logged. 
    shift  # remove the log file name. 
    echo $(date +"%D %H %M") "$@" >>"$logfile"
}

# wasted 2 hours analysing without log files. 
 function backup() {

    local dir="$1"
    log logfile "$dir passed into function"
    # check if it is empty string. 
    [[ -z "$dir" ]] && {
        echo "$dir should be readable and writable" 1>&2
    }
    log logfile "$dir afterwards empty check"
    [[  -w "$dir" && -r "$dir"  ]] || {
        echo "$dir should be readable and writable" 1>&2
        return 1
    }

    tar -cvf backup.tar "$dir"
}
