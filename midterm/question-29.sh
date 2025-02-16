#!/bin/bash
# Create the example file
echo "user1:additional:fields:more:info" > example-passwd
echo "user2:more:fields:to:test" >> example-passwd
echo "user3:testing:more:examples" >> example-passwd
# Extract the first field using cut and pipe it to more
cut -d: -f1 | less -de < example-passwd