<<EOF
    EASY
    Self-reproducing Script
    Write a script that backs itself up, that is, copies itself to a file named backup.sh.
    Hint: Use the cat command and the appropriate positional parameter.
EOF

# my notes. 
# when a shell script is invoked
# it writes the backup.sh in the directory
# it wants.

cat "$0" > backup.sh




