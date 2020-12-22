load 'libs/bats-support/load'
load 'libs/bats-assert/load'


function setup() {

    source ../disk_space_management.sh
    cat <<EOF > bigfile
The ongoing race between the ruling Trinamul Congress and the BJP in breaking each other’s “home” through the politics of defection ahead of next year’s Assembly Election escalated to marital discord on Monday as chief minister Mamata Banerjee’s party virtually struck Bishnupur BJP MP Saumitra Khan’s heart and roped his wife Sujata Mondal Khan into its fold to avenge the switchover of Shubhendu Adhikari to the saffron party two days ago.
The ongoing race between the ruling Trinamul Congress and the BJP in breaking each other’s “home” through the politics of defection ahead of next year’s Assembly Election escalated to marital discord on Monday as chief minister Mamata Banerjee’s party virtually struck Bishnupur BJP MP Saumitra Khan’s heart and roped his wife Sujata Mondal Khan into its fold to avenge the switchover of Shubhendu Adhikari to the saffron party two days ago.
EOF

# setting the test data in recursive way. 
    for i in {1..125}; do  cat bigfile ; done >> bigfile1
    mkdir -p dir1/dir2 
    mv bigfile bigfile1 dir1/
    cp  dir1/bigfile dir1/dir2/bigfile3
    cp  dir1/bigfile1 dir1/dir2/bigfile4

}

@test "test num_args" {
    run disk_space_mgmt 
    assert_line 'Usage: disk_space_mgmt <directory>'

}

@test "test file sizes in directory" {
    run disk_space_mgmt "dir1"
    
    assert_output <<- EOF
dir1/bigfile1
dir1/dir2/bigfile4
EOF

}


function teardown() {
   #  rm -rf dir1
    echo 
}


