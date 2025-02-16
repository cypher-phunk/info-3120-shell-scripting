#!/bin/bash

# Function to check the position of a dot (.) in the PATH
check_path_dot_position() {
    local path="$1"

    case "$path" in
        # Check if there's a dot at the beginning
        :*|.:*)
            echo "There is a dot at the beginning of the PATH."
            ;;
        # Check if there's a dot at the end
        *:|*:.)
            echo "There is a dot at the end of the PATH."
            ;;
        # Check if there's a dot somewhere in the middle
        *::*|*:.:*)
            echo "There is a dot somewhere in the middle of the PATH."
            ;;
        *)
            echo "There is no dot affecting the PATH in a special position."
            ;;
    esac
}

# Test the function with different PATH scenarios
echo "Testing various PATH configurations..."

# Example scenarios
# 1. No dot affecting PATH
check_path_dot_position "/usr/bin:/bin"

# 2. Dot at the beginning (.:/usr/bin:/bin)
check_path_dot_position ".:/usr/bin:/bin"

# 3. Dot at the end (/usr/bin:/bin:.)
check_path_dot_position "/usr/bin:/bin:."

# 4. Dot in the middle (/usr/bin:/:/bin)
check_path_dot_position "/usr/bin:/:/bin"

# 5. Combined dots (::, :.: due to typo)
check_path_dot_position ":::usr/bin:/bin"

# 6. Dot at beginning and end (.:/usr/bin:/bin:)
check_path_dot_position ".:/usr/bin:/bin:."

# 7. Multiple dots (:::, ::)
check_path_dot_position ":::usr/bin:/:/bin"

# Note: For actual testing, modify your env PATH to test without altering this script