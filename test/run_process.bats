#!/usr/bin/env ./libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup() {

    source ../run_process.sh
}


@test "test something." {
    run 
}

