#!/bin/bash

ram_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

total_ram=$(free -h | grep Mem | awk '{print $2}')
available_ram=$(free -h | grep Mem | awk '{print $7}')

log_dir="$(dirname "$0")/../log"
log_file="$log_dir/fragment.log"

mkdir -p "$log_dir"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Fragment Usage [$ram_usage%] - Fragment Count [$total_ram] - Details [Total: $total_ram, Available: $available_ram]" >> $log_file
