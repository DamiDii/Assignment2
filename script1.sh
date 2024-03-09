#!/bin/bash

# Set default values
list_contents=false
top_entries=8

# Function to display usage information
usage() {
    echo "Usage: $0 [-d] [-n N] directory ..." >&2
    echo "   -d   List all files and directories within the specified directories" >&2
    echo "   -n N Specify the top N entries to be returned (default is 8)" >&2
    exit 1
}

# Parse command line arguments
while getopts ":dn:" opt; do
    case ${opt} in
        d )
            list_contents=true
            ;;
        n )
            top_entries=$OPTARG
            ;;
        \? )
            usage
            ;;
        : )
            echo "Invalid option: $OPTARG requires an argument" >&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check for compulsory argument
if [ $# -eq 0 ]; then
    echo "Please provide at least one directory to check disk usage" >&2
    usage
fi

# Main script logic
for directory in "$@"; do
    if $list_contents; then
        echo "Disk usage for files and directories in $directory:"
        du -h $directory | sort -rh | head -n $top_entries
    else
        echo "Disk usage for directories in $directory:"
        du -h --max-depth=1 $directory | sort -rh | head -n $top_entries
    fi
    echo
done