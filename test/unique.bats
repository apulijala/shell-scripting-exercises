#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup() {
    source ../unique.sh
}   


@test "should not contain filename" {
    run unique_system
    refute_line --partial '/etc/passwd'
}
