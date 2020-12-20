#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup()  {
 run ../itself.sh

}

@test 'describe test for assert_equal()' {
    
    # verfication of existence
    run ls backup.sh
    [ "$status" -eq 0 ]
    # verification of content.
    run diff backup.sh ../itself.sh
    assert_output ''
}

function teardown() {
    rm backup.sh
}

