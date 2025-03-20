#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../log"
mkdir -p "$LOG_DIR"

while true; do
    # Menu utama
    echo "========================"
    echo "1. Add CPU Monitoring"
    echo "2. Remove CPU Monitoring"
    echo "3. Add RAM Monitoring"
    echo "4. Remove RAM Monitoring"
    echo "5. View Active Jobs"
    echo "6. Exit"
    read -p "Choose an option: " choice
    echo "========================"

    case $choice in
        1)
            if crontab -l 2>/dev/null | grep -q "core_monitor.sh"; then
                echo "CPU monitoring is already active."
            else
                (crontab -l 2>/dev/null | grep -v "core_monitor.sh"; echo "* * * * * $SCRIPT_DIR/core_monitor.sh >> $LOG_DIR/core.log") | crontab -
                echo "CPU monitoring added."
            fi
            ;;
        2)
            crontab -l | grep -v "core_monitor.sh" | crontab -
            echo "CPU monitoring removed."
            ;;
        3)
            if crontab -l 2>/dev/null | grep -q "frag_monitor.sh"; then
                echo "RAM monitoring is already active."
            else
                (crontab -l 2>/dev/null | grep -v "frag_monitor.sh"; echo "* * * * * $SCRIPT_DIR/frag_monitor.sh >> $LOG_DIR/fragment.log") | crontab -
                echo "RAM monitoring added."
            fi
            ;;
        4)
            crontab -l | grep -v "frag_monitor.sh" | crontab -
            echo "RAM monitoring removed."
            ;;
        5)
            echo "Active CPU and RAM Monitoring Jobs:"
            crontab -l | grep -E "core_monitor.sh|frag_monitor.sh" || echo "No active monitoring jobs found."
            ;;
        6)
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done
