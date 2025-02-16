#!/bin/bash

# Create a test file with mixed-case letters
echo "This is a MiXeD CaSe TeSt StRiNg." > testfile.txt

# Run the command
tr 'a-z' 'A-Z' < testfile.txt | tr 'A-Z' 'a-z' > outputfile.txt

# Verify the output
echo "Original file:"
cat testfile.txt

echo "\nOutput file (after tr 'a-z' 'A-Z' | tr 'A-Z' 'a-z'):"
cat outputfile.txt

# Clean up
rm testfile.txt outputfile.txt

echo "\nExpected result: The output file should be identical to the original file."