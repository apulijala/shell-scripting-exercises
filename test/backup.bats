#!/usr/bin/env ./libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup() {

    source ../backup.sh    
    mkdir errordir
    mkdir correctdir
    touch correctdir/file{1..4}.txt
}

# don't set up the test harnesses in 
# the function. 

@test "test error msg for read-write" {

    chmod u=-rw errordir
    # run backup errordir
    run backup errordir
    assert_line "errordir should be readable and writable"
    chmod 777 errordir
}

# status code need to be checked using the 
# error code without the run operator. 

@test "test the tar file creation" {

    run backup correctdir
    [ -e backup.tar ]
}

function teardown() {

   rm  backup.tar 
   rm -rf  errordir
   rm -rf correctdir
}
