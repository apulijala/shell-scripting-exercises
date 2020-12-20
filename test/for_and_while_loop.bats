load 'libs/bats-support/load'
load 'libs/bats-assert/load'

function setup()  {
 source ../for_to_while_loop.sh

}

@test 'describe test for assert_equal()' {
    
    # verfication of existence
    run diff <(planets_using_for_loop)  <(planets_using_while_loop )
    [ "$status" -eq 0 ]
    # verification of content.
    assert_output ''
}
