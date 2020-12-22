<<EOF
11:24 - 11:41
Managing Disk Space
List, one at a time, all files larger than 
100K in the /home/username directory tree. 
Give the user the option to delete or 
compress the file, then proceed to show the #
next one. Write to a logfile the names of 
all deleted files and the deletion times.
EOF

tmpfile="/tmp/$$.$0"
trap  'rm $tmpfile; exit' SIGHUP SIGINT  SIGQUIT SIGILL  SIGILL SIGTERM EXIT 
# : { ARCHIVEDIR:="archivedir" }
: "${ARCHIVEDIR:=archivedir}"


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
    echo "$(date +"%D %H %M")" "$@" >>"$logfile"
}




function disk_space_mgmt() {
   
    [ $# -ne 1 ] && {
        echo "Usage: disk_space_mgmt <directory>"
        return 1
    }

    dir1="$1"
    find "$dir1" -type f -size +100k 
}

# within a pipe prompt you cannot use another read. 
# and even array is not working within a pipeline. 
# final way is to write it to temporary file. 


function prompt_user_for_deletion() {
    
    local files_to_process=()
    disk_space_mgmt  "$1" > "$tmpfile"
    exec 3<"$tmpfile"
    while read -r <&3 file
    do 
        echo "$file"
       files_to_process+=("$file")
    done 

    declare -l choice
    for file in "${files_to_process[@]}"
    do 
        read -r -p  "Do you want to remove or compress $file ? " choice
        if [[ "$choice" == "remove"  ]]
        then 
            rm -- "$file"
        else 
            mv "$file" "$ARCHIVEDIR"
        fi
    done

}









