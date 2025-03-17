#!/bin/bash

clear

speak_to_me() {
    while true; do
        curl -s https://www.affirmations.dev | jq -r '.affirmation'
        sleep 1
    done
}

on_the_run() {
    local progress=0
    local bar_length=50
    while [ $progress -le 100 ]; do
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
        local filled=$((progress * bar_length / 100))
        printf "\r[%-${bar_length}s] %d%%" $(head -c $filled < /dev/zero | tr '\0' '#') $progress
        ((progress += RANDOM % 10 + 5))
    done
    echo "\nSelesai!"
}

time_display() {
    while true; do
        clear
        date "+%Y-%m-%d %H:%M:%S"
        sleep 1
    done
}

money_matrix() {
    symbols=("$" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣")
    while true; do
        printf "\e[2J"
        for _ in $(seq 1 20); do
            line=""
            for _ in $(seq 1 40); do
                line+="${symbols[RANDOM % ${#symbols[@]}]} "
            done
            echo "$line"
        done
        sleep 0.1
    done
}

brain_damage() {
    while true; do
        clear
        ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -10
        sleep 1
    done
}

display_help() {
    echo "Penggunaan: ./dsotm.sh --play=\"<Track>\""
    echo "Pilihan Track:"
    echo "  Speak to Me    - Kata-kata afirmasi"
    echo "  On the Run     - Progress bar"
    echo "  Time          - Jam real-time"
    echo "  Brain Damage  - Task manager sederhana"
    echo "  Money         - Animasi simbol mata uang"
}

if [[ "$1" == "--play="* ]]; then
    track=${1#--play=}
    case "$track" in
        "Speak to Me") speak_to_me ;; 
        "On the Run") on_the_run ;; 
        "Time") time_display ;; 
        "Brain Damage") brain_damage ;; 
        "Money") money_matrix ;; 
        *) echo "Track tidak dikenali!"; display_help;;
    esac
else
    display_help
fi
