#!/bin/bash
<<EOF
Convert the for loops in Example 11-1 to while loops. 
Hint: store the data in an array and step through the 
array elements.
Having already done the "heavy lifting," now convert 
the loops in the example to until loops.
EOF

function planets_using_for_loop() {
    for planet in Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto
    do
    echo $planet  # Each planet on a separate line.
    done
    echo; echo
    for planet in "Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto"
        # All planets on same line.
        # Entire 'list' enclosed in quotes creates a single variable.
        # Why? Whitespace incorporated into the variable.
    do
    echo $planet
    done
    echo; echo "Whoops! Pluto is no longer a planet!"

}

function planets_using_while_loop() {
    planets=("Mercury" "Venus" "Earth" "Mars" "Jupiter" "Saturn" "Uranus" "Neptune" "Pluto")
    i=0
    # For numerical comparitions use -lt and for strings
    # use < 
    while [[ $i -lt ${#planets[@]} ]]
    do 
        echo ${planets["$i"]}
        ((i=i+1))
    done
    echo; echo
    echo "${planets[@]}"
    echo; echo "Whoops! Pluto is no longer a planet!"
    
}










