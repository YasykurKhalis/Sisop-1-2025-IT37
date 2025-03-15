#!/bin/bash

# Function for "Speak to Me"
speak_to_me() {
    echo "Welcome to Dark Side of the Moon Script!"
    echo "Enjoy the journey!"
}

# Function for "On the Run"
on_the_run() {
    echo -n "Loading: "
    for i in {1..10}; do
        echo -n "#"
        sleep 0.2
    done
    echo " Done!"
}

# Function for "Time"
time_display() {
    while true; do
        clear
        echo "Current Time: $(date '+%H:%M:%S')"
        sleep 1
    done
}

# Function for "Brain Damage"
brain_damage() {
    ps aux --sort=-%mem | head -10
}

# Main script logic
case "$1" in
    --play="Speak to Me")
        speak_to_me
        ;;
    --play="On the Run")
        on_the_run
        ;;
    --play="Time")
        time_display
        ;;
    --play="Brain Damage")
        brain_damage
        ;;
    *)
        echo "Usage: $0 --play=\"Speak to Me\"|\"On the Run\"|\"Time\"|\"Brain Damage\""
        exit 1
        ;;
esac
