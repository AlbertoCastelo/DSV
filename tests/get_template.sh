#!/bin/sh

# test get template

python dsgit/dsgit.py get_template ./tests

# this should work but does not
# dsgit get_template ./tests


FILE=./tests/base-template.ipynb

if [ -f "$FILE" ]; then
    echo "$FILE exists. Deleting it"
    rm $FILE
    exit 0
else 
    echo "$FILE does NOT exist."
    exit 1
fi
