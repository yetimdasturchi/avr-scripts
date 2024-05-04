#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "$1 file not exists."
    exit 1
fi

data_size=$(avr-objdump -h $1 | awk '/\.data/ {print $3}')

bss_size=$(avr-objdump -h $1 | awk '/\.bss/ {print $3}')

stack_size=$(avr-objdump -h $1 | awk '/\.stack/ {print $3}')

data_size_dec=$(( 0x$data_size ))
bss_size_dec=$(( 0x$bss_size ))
stack_size_dec=$(( 0x$stack_size ))

total_ram_size=2048

total_ram_usage=$(( data_size_dec + bss_size_dec + stack_size_dec ))

total_percentage=$(( total_ram_usage * 100 / total_ram_size ))
data_percentage=$(( data_size_dec * 100 / total_ram_size ))
bss_percentage=$(( bss_size_dec * 100 / total_ram_size ))
stack_percentage=$(( stack_size_dec * 100 / total_ram_size ))

echo "RAM Usage Statistics (Maximum is $total_ram_size bytes):"
echo "-------------------------------------------------------"
echo ".data section:   ${data_size_dec:-0} bytes (${data_percentage:-0}%)"
echo ".bss section:    ${bss_size_dec:-0} bytes (${bss_percentage:-0}%)"
echo ".stack section:  ${stack_size_dec:-0} bytes (${stack_percentage:-0}%)"
echo "-------------------------------------------------------"
echo "Total RAM usage: $total_ram_usage bytes (${total_percentage:-0}%)"
