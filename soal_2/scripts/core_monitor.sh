#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

cpu_model=$(lscpu | grep "Model name" | cut -d ':' -f 2 | xargs)

log_dir="$(dirname "$0")/../log"
log_file="$log_dir/core.log"

mkdir -p "$log_dir"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_model]" >> $log_file
