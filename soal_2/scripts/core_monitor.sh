#!/bin/bash

# Ambil persentase penggunaan CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Ambil model CPU
cpu_model=$(lscpu | grep "Model name" | cut -d ':' -f 2 | xargs)

# Log ke file
log_dir="$(dirname "$0")/../logs"
log_file="$log_dir/core.log"

mkdir -p "$log_dir"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Core Usage [$cpu_usage%] - Terminal Model [$cpu_model]" >> $log_file
