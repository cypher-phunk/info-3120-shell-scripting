#!/bin/bash

# Test script for sed command functionality

# Function to test command 1
test_command1() {
    echo "Testing Command 1: Deletes lines 1 and 2 and prints fields 1,5,6,7"
    input_file="input_colon.txt"
    expected_output="expected_output1.txt"

    # Create test input file
    echo "Line 1:Col1:Col2:Col3:Col4:Col5:Col6:Col7" > "$input_file"
    echo "Line 2:Col8:Col9:Col10:Col11:Col12:Col13:Col14" >> "$input_file"
    echo "Line 3:Data1:Data2:Data3:Data4:Data5:Data6:Data7" >> "$input_file"

    # Execute command and capture output
    sed -e '1,2d' -e 's/\(.*\):\(.*\):\(.*\):\(.*\):\(.*\):\(.*\):\(.*\)/\1:\5:\6:\7/' "$input_file" > output.txt

    # Check the output
    if [ -f "output.txt" ]; then
        echo "Output file generated successfully."
        # Compare with expected output
        if cmp -s "output.txt" "$expected_output"; then
            echo "Command 1: Test passed"
        else
            echo "Command 1: Test failed. Output does not match expected."
        fi
    else
        echo "Command 1: Test failed. Output file not generated."
    fi
}

# Function to test command 2
test_command2() {
    echo "Testing Command 2: Produces a syntax error"
    input_file="input_colon.txt"

    # Execute command and capture output
    sed -sed -e '1,2d' $1e 's/\(.*\):\(.*\):\(.*\):\(.*\):\(.*\):\(.*\):\(.*\)/\1:\5:\6:\7/' "$input_file" > output2.txt 2>&1

    if [ -f "output.txt" ]; then
        # Check for syntax error message
        if grep -q "sed: .* invalid command" "output.txt"; then
            echo "Command 2: Test passed"
        else
            echo "Command 2: Test failed. No syntax error detected."
        fi
    else
        echo "Command 2: Test failed. Output file not generated."
    fi
}

# Function to test command 3
test_command3() {
    echo "Testing Command 3: Deletes lines 1 and 2"
    input_file="input_delete.txt"
    output_file="output3.txt"

    # Create test input file
    echo "Line 1" > "$input_file"
    echo "Line 2" >> "$input_file"
    echo "Line 3" >> "$input_file"
    echo "Line 4" >> "$input_file"

    # Execute command and capture output
    sed -e '1,2d' "$input_file" > "$output_file"

    # Check the output
    if [ -f "$output_file" ]; then
        expected_lines=$(wc -l < "$output_file")
        if [ "$expected_lines" -eq 2 ]; then
            # Verify lines 3 and 4 are present
            if grep -q "Line 3" "$output_file" && grep -q "Line 4" "$output_file"; then
                echo "Command 3: Test passed"
            else
                echo "Command 3: Test failed. Incorrect lines in output."
            fi
        else
            echo "Command 3: Test failed. Incorrect number of lines in output."
        fi
    else
        echo "Command 3: Test failed. Output file not generated."
    fi
}

# Function to test command 4
test_command4() {
    echo "Testing Command 4: Equivalent to grep '^s'"
    input_file="input_grep.txt"
    output_file="output4.txt"

    # Create test input file
    echo "starting line" > "$input_file"
    echo "second line" >> "$input_file"
    echo "succeeded" >> "$input_file"

    # Execute command
    sed -n -e '/^s/p' "$input_file" > "$output_file"

    # Check the output
    if [ -f "$output_file" ]; then
        if grep -q "starting line" "$output_file" && grep -q "succeeded" "$output_file" && ! grep -q "second line" "$output_file"; then
            echo "Command 4: Test passed"
        else
            echo "Command 4: Test failed. Output does not match expected."
        fi
    else
        echo "Command 4: Test failed. Output file not generated."
    fi
}

# Function to test command 5
test_command5() {
    echo "Testing Command 5: Swap columns 1 and 3, append original"
    input_file="input_comma.txt"
    output_file="output5.txt"

    # Create test input file
    echo "1,2,3" > "$input_file"
    echo "a,b,c" >> "$input_file"

    # Execute command
    sed -e 's/^\(.*\),\(.*\),\(.*\)$/\3,\2,\1,&/' "$input_file" > "$output_file"

    # Check the output
    if [ -f "$output_file" ]; then
        if grep -q "3,2,1,1,2,3" "$output_file" && grep -q "c,b,a,a,b,c" "$output_file"; then
            echo "Command 5: Test passed"
        else
            echo "Command 5: Test failed. Output does not match expected."
        fi
    else
        echo "Command 5: Test failed. Output file not generated."
    fi
}

# Function to test command 6
test_command6() {
    echo "Testing Command 6: Append original line"
    input_file="input_line.txt"
    output_file="output6.txt"

    # Create test input file
    echo "Sample line" > "$input_file"
    echo "Another line" >> "$input_file"

    # Execute command
    sed -e 's/.*$/& &/' "$input_file" > "$output_file"

    # Check the output
    if [ -f "$output_file" ]; then
        if grep -q "Sample line Sample line" "$output_file" && grep -q "Another line Another line" "$output_file"; then
            echo "Command 6: Test passed"
        else
            echo "Command 6: Test failed. Output does not match expected."
        fi
    else
        echo "Command 6: Test failed. Output file not generated."
    fi
}

# Main execution
echo "Starting sed command tests..."

test_command1
test_command2
test_command3
test_command4
test_command5
test_command6

echo "Tests completed."
