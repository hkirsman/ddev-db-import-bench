#!/bin/bash
#
# Testing Lando import speed
#

lando start

# Define the array of tests.
tests=(
    "Test 1"
    "Test 2"
    "Test 3"
)

# Iterate over the tests and execute them.
for test in "${tests[@]}"
do
    lando delete --omit-snapshot --yes && lando start
    echo "$test"
    time lando db-import db.sql
done
