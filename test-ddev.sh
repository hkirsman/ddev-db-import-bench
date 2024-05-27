#!/bin/bash
#
# Testing DDEV import speed
#

# Define the array of tests.
tests=(
    "Test 1"
    "Test 2"
    "Test 3"
)

# Iterate over the tests and execute them.
for test in "${tests[@]}"
do
    ddev delete --omit-snapshot --yes && ddev start
    echo "$test"
    time ddev import-db --file=./db.sql
done
