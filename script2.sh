#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 source_directory destination_directory" >&2
    exit 1
}

# Check for correct number of arguments
if [ $# -ne 2 ]; then
    usage
fi

# Assign arguments to variables
source_dir="$1"
dest_dir="$2"

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory '$source_dir' does not exist or is not a directory" >&2
    exit 1
fi

# Check if destination directory exists, if not create it
if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
fi

# Create backup filename with timestamp
backup_file="$dest_dir/backup_$(date +'%Y%m%d_%H%M%S').tar.gz"

# Create tar archive of source directory
tar -czf "$backup_file" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"

echo "Backup created: $backup_file"