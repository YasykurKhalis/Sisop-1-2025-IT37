#!/bin/bash

mkdir -p "$(dirname "$(realpath "$0")")/../logs"

# Menu utama
echo "1. Add CPU Monitoring"
echo "2. Remove CPU Monitoring"
echo "3. Add RAM Monitoring"
echo "4. Remove RAM Monitoring"
echo "5. View Active Jobs"
echo "6. Exit"

read -p "Choose an option: " choice

case $choice in
    1)
        # Tambahkan cron job untuk CPU monitoring
        (crontab -l 2>/dev/null; echo "* * * * * $(pwd)/core_monitor.sh >> $(pwd)/logs/core.log 2>&1") | crontab -
        echo "CPU monitoring added."
        ;;
    2)
        # Hapus cron job untuk CPU monitoring
        crontab -l | grep -v "$(pwd)/core_monitor.sh" | crontab -
        echo "CPU monitoring removed."
        ;;
    3)
        # Tambahkan cron job untuk RAM monitoring
        (crontab -l 2>/dev/null; echo "* * * * * $(pwd)/frag_monitor.sh >> $(pwd)/logs/fragment.log 2>&1") | crontab -
        echo "RAM monitoring added."
        ;;
    4)
        # Hapus cron job untuk RAM monitoring
        crontab -l | grep -v "$(pwd)/frag_monitor.sh" | crontab -
        echo "RAM monitoring removed."
        ;;
    5)
        # Tampilkan cron job aktif
        crontab -l
        ;;
    6)
        exit 0
        ;;
    *)
        echo "Invalid option."
        ;;
esac
