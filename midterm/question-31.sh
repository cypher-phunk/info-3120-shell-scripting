#!/bin/bash

# Create a test file with various names and ages
echo "Creating test file..."
cat > names.txt << EOF
John Smith 25 NewYork
Alice Johnson 30 Chicago
Bob Wilson 22 Boston
Mary Davis 28 LosAngeles
James Brown 27 Houston
EOF

echo "Original file contents:"
cat names.txt

echo "\nSorted by fields 2 and 3 (last name and age):"
sort +2 -3 names.txt

echo "\nTesting edge cases..."
echo "Adding some variations to test sorting:"
cat >> names.txt << EOF
amy SMITH 31 Denver
Zack brown 29 Seattle
EOF

echo "\nTesting with updated file:"
sort +2 -3 names.txt

echo "\nCleaning up..."
rm names.txt