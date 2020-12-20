#!/bin/bash

<<EOF
Automatically Decompressing Files
Given a list of filenames as input, this 
script queries each target file 
(parsing the output of the file command) 
for the type of compression used on it. 
Then the script automatically invokes the 
appropriate decompression command 
(gunzip, bunzip2, unzip, uncompress, 
or whatever). 
If a target file is not compressed, 
the script emits a warning message, 
but takes no other action on that particular file.
EOF

function log() {

    logfile="$1"
    dir="${logfile%/*}" #  Get the directory. 


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

function status_check () {

    status="$1"
    file="$2"
    if [[ "$status" -ne 0 ]]
    then 
        log logfile "$file cannot be decompressed"
    fi 
}

for file in "$@"
do 
    if [ ! -f "$file" ]
    then 
        log logfile "$file is not a valid file"
        continue
    fi 
   
    result=$(file "$file")
    if echo "$result" | grep "tar" >/dev/null
    then 
        log logfile "$file is a tar file"
        tar xvf "$file" > /dev/null

    elif echo "$result" | grep "bzip2" > /dev/null
    then
        log logfile "$file is a bunzip file"
        bunzip2 "$file" > /dev/null
    elif echo "$result" | grep "gzip" >/dev/null
    then 
        log logfile "$file is a gzip file"
        gunzip "$file" > /dev/null
    else 
        log logfile "$file is an ordianary file"
    fi
    # status_check $? "$file"
done
