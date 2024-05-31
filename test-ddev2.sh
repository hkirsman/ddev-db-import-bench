#!/bin/bash

# Configuration file path
config_file=".ddev/mysql/lando.cnf"
backup_file=".ddev/mysql/lando.cnf.bak"

# Backup the original configuration file
cp "$config_file" "$backup_file"

# Initialize output file
output_file="out.csv"
> "$output_file"  # Clear the output file before starting

run_tests() {
    # Set the number of iterations
    local iterations=2

    # Set the TIMEFORMAT to show only the elapsed time in seconds
    local TIMEFORMAT='%R'

    # Perform the iterations
    for ((i=1; i<=iterations; i++))
    do
        ddev delete --omit-snapshot --yes
        ddev start
        local command="ddev import-db --no-progress --file=./db2.sql"

        # Capture the time output
        { time $command; } 2> temp_time.txt

        # Read the elapsed time and remove the newline
        local elapsed_time=$(tr -d '\n' < temp_time.txt)

        # Append the elapsed time to the output file
        echo -n "$elapsed_time;" >> "$output_file"
    done

    # Clean up
    rm temp_time.txt
}

# Read the configuration file into an array
mapfile -t lines < "$config_file"

# Process each line in the array
for line in "${lines[@]}"; do
  # Skip lines that are comments, section headers, or empty
  if [[ "$line" =~ ^\s*# ]] || [[ "$line" =~ ^\s*\[ ]] || [[ -z "$line" ]]; then
    continue
  fi

  # Display the line being tested
  echo "$line;"
  echo -n "$line;" >> "$output_file"

  # Disable the line in the configuration file by commenting it out
  sed -i "s|^$(echo "$line" | sed 's/[]\/$*.^|[]/\\&/g')|#&|" "$config_file"

  run_tests

  # Append a new line to the output file
  echo >> "$output_file"

  # Restore the original configuration file
  cp "$backup_file" "$config_file"

done

# Clean up: remove the backup file
rm "$backup_file"

echo "All lines have been tested."
