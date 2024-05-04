#!/bin/bash

max_size=32256

if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "$1 file not exists."
    exit 1
fi

avr-nm --size-sort $1 | {
    total_size=0

    while read -r size type name; do
        size_dec=$(( 0x${size} ))

        total_size=$(( total_size + size_dec ))

        percentage=$(( size_dec * 100 / max_size ))

        echo "${name}: ${size_dec} bytes (${percentage}%)"
    done

    total_percentage=$(( total_size * 100 / max_size ))

    echo "-------------------------------"
    echo "Total size: ${total_size} bytes (${total_percentage}%)"
}
