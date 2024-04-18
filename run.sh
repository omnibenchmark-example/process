#!/bin/bash

# Set the entrypoint of your module
SCRIPT_PATH='entrypoint_process.R'

# Check if all the arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <output_dir> <name> [<input_file1> <input_file2> ...] [<extra_args> ...]"
    exit 1
fi

# Get the output directory, and name from the arguments
output_dir=$1
name=$2

# Check if the Python/R script file exists
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Error: Python/R script '$SCRIPT_PATH' not found."
    exit 1
fi

# Check if the output directory exists; if not, create it
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir" || { echo "Error: Failed to create output directory '$output_dir'."; exit 1; }
fi

# Shift the arguments to skip the first two (output_dir, name)
shift 2

# Run the Python/R script with the provided arguments
extension="${SCRIPT_PATH##*.}"
case "$extension" in
    "py")
        python3 "$SCRIPT_PATH" --output_dir "$output_dir" --name "$name" "$@"
        ;;
    "R")
        Rscript "$SCRIPT_PATH" --output_dir "$output_dir" --name "$name" "$@"
        ;;
esac
