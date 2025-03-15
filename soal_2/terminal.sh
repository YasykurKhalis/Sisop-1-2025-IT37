#!/bin/bash

while true; do
    echo "1. Register"
    echo "2. Login"
    echo "3. Exit"
    read -p "Choose an option: " choice

    case $choice in
        1)
            ./register.sh
            ;;
        2)
            ./login.sh
            if [ $? -eq 0 ]; then
                ./scripts/manager.sh
            fi
            ;;
        3)
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done
