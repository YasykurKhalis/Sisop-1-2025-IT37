#!/bin/bash

# Ambil penggunaan RAM dalam persentase
ram_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Ambil total dan available RAM
total_ram=$(free -h | grep Mem | awk '{print $2}')
available_ram=$(free -h | grep Mem | awk '{print $7}')

# Log ke file
log_file="../logs/fragment.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] - Fragment Usage [$ram_usage%] - Fragment Count [$total_ram] - Details [Total: $total_ram, Available: $available_ram]" >> $log_file
