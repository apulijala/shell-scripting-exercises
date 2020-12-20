<<EOF
16:22
Unique System ID
Generate a "unique" 6-digit 
hexadecimal identifier 
for your computer. 
Do not use the flawed hostid command. 
Hint: md5sum /etc/passwd, 
then select the first 6 digits of output.
EOF

function unique_system() {
    md5sum /etc/passwd |\
    awk '{print $1}'
}
