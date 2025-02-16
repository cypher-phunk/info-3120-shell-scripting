#!/bin/bash

# Define a variable for testing
test_var="filename"

# Function to test expansions
test_expansion() {
    local result=$1  # expansion result
    if [[ "$result" == *"$test_var"* ]]; then
        echo "Expands"  # indicates filename generation happened
    else
        echo "Does not expand"  # filename generation did not happen
    fi
}

# Test single quotes (no expansion)
result1='This will not expand the "$test_var"'
echo "Single quotes: $result1"
exp_single_quotes=$(test_expansion "$result1")

# Test double quotes (expansion occurs)
result2="This will expand the $test_var"
echo "Double quotes: $result2"
exp_double_quotes=$(test_expansion "$result2")

# Test backticks (expansion occurs)
result3="This will expand when using backticks: `echo $test_var`"
echo "Backticks: $result3"
exp_backticks=$(test_expansion "$result3")

# Test $(...) as an alternative to backticks (expansion occurs)
result4="This will expand when using $(echo $test_var)"
echo "Command substitution: $result4"
exp_command_substitution=$(test_expansion "$result4")

# Determine the correct answer
if [[ "$exp_double_quotes" == "Expands" && "$exp_backticks" == "Expands" && "$exp_command_substitution" == "Expands" ]]; then
    echo "Correct Answer: d (B & C)"
elif [[ "$exp_single_quotes" == "Expands" && "$exp_double_quotes" == "Expands" && "$exp_backticks" == "Expands" ]]; then
    echo "Correct Answer: e (A & B & C)"
elif [[ "$exp_double_quotes" == "Expands" && "$exp_backticks" == "Expands" ]]; then
    echo "Correct Answer: d (B & C)"
elif [[ "$exp_single_quotes" == "Expands" && "$exp_double_quotes" == "Expands" ]]; then
    echo "Correct Answer: e (A & B & C)"
elif [[ "$exp_double_quotes" == "Expands" ]]; then
    echo "Correct Answer: b"
elif [[ "$exp_backticks" == "Expands" || "$exp_command_substitution" == "Expands" ]]; then
    echo "Correct Answer: c"
fi