#!/bin/bash

# Test command with no arguments
test
echo "Exit status of 'test' with no arguments: $?"

# Test command with a true expression
test 1 -eq 1
echo "Exit status of 'test 1 -eq 1': $?"

# Test command with a false expression
test 1 -eq 2
echo "Exit status of 'test 1 -eq 2': $?"

# [ expression ] with a true expression
[ 1 -eq 1 ]
echo "Exit status of '[ 1 -eq 1 ]': $?"

# [ expression ] with a false expression
[ 1 -eq 2 ]
echo "Exit status of '[ 1 -eq 2 ]': $?"

# [ expression ] with missing spaces (syntax error)
#[1 -eq 1]  # Uncommenting this line will cause a syntax error
#echo "Exit status of '[1 -eq 1]': $?"  # This line won't be reached if the above is uncommented